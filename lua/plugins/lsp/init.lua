-- NOTE: This is where your plugins related to LSP can be installed.
--  The configuration is done below. Search for lspconfig to find it below.
return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      'williamboman/mason.nvim',
      dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
      },
    },
    'williamboman/mason-lspconfig.nvim',

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  -- event = { 'BufEnter' },
  config = function()
    local lspconfig = require 'lspconfig'
    local util = require 'lspconfig.util'

    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>cr', vim.lsp.buf.rename, 'Rename')
      -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      -- nmap('<leader>ca', '<cmd>CodeActionMenu<cr>', '[C]ode [A]ction')

      -- Move to definition and center cursor on screen
      -- NOTE: <cmd>lua vim.lsp.buf.definition()<CR>zz for centering after
      nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('gR', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- disable formatting
      -- client.resolved_capabilities.document_formatting = false
      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format {
          bufnr = bufnr,
          timeout_ms = 2000,
          filter = function(c)
            -- volar conflict with null-ls eslint formatter
            if (c.name == 'volar' or c.name == 'tsserver') and c.name ~= 'null-ls' then
              return false
            end
            return true
          end,
        }
      end, { desc = 'Format current buffer with LSP' })
    end

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup()
    require('mason-lspconfig').setup()

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local servers = {
      volar = {},
      jsonls = {},
      pyright = {},
      rust_analyzer = {},
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      marksman = {},
      tailwindcss = { filetypes = { 'html', 'twig', 'css', 'jsx', 'vue' } },
      gopls = {},
      intelephense = {},
      -- only for php 8.0+
      -- phpactor = {},
      tsserver = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }
    mason_tool_installer.setup {
      ensure_installed = {
        'stylua',            -- lua formatter
        'eslint',            -- js/ts formatter/linter
        'php-cs-fixer',      -- php formatter
        'prettierd',         -- general formatter (markdown, json, etc)
        'markdownlint',      -- markdown linter
        'golangci-lint',     -- go linter
        'phpcs',             -- php linter

        -- include in gopls lsp
        -- 'gofmt',
      },
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    }

    lspconfig['sourcekit'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        vim.trim(vim.fn.system 'xcrun -f sourcekit-lsp'),
        -- NOTE: if not work, use full path
        -- '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp',
      },
      root_dir = function(filename, _)
        return util.root_pattern 'buildServer.json' (filename)
            or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
            or util.find_git_ancestor(filename)
            or util.root_pattern 'Package.swift' (filename)
      end,
    }
  end,
}
