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
   },
   event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
   opts = {
      codelens = {
         enabled = true,
      },
   },
   config = function()
      local lspconfig = require 'lspconfig'
      local util = require 'lspconfig.util'

      -- vim.api.nvim_create_autocmd('BufEnter', {
      --    callback = function()
      --       if vim.bo.filetype == 'swift' and #(vim.lsp.get_clients { name = 'sourcekit' }) == 0 then
      --          vim.lsp.start(lspconfig['sourcekit'])
      --       end
      --    end,
      --    desc = 'Start sourcekit on swift files if not already started (enter file or lsp crashed)',
      -- })

      local on_attach = function(client, bufnr)
         -- for inline diagnostic messages, use tiny-inline-diagnostic instead
         vim.diagnostic.config { virtual_text = false }
         vim.print(client.config.settings)

         local nmap = function(keys, func, desc)
            if desc then
               desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
         end

         nmap('<leader>cr', vim.lsp.buf.rename, 'Rename')

         -- Move to definition and center cursor on screen
         -- NOTE: <cmd>lua vim.lsp.buf.definition()<CR>zz for centering after
         nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
         nmap('gR', require('telescope.builtin').lsp_references, 'Goto References')
         nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
         nmap('gy', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')
         nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
         nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

         -- See `:help K` for why this keymap
         -- TODO: in neovim 0.10 this is default keymap, mb remove
         nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
         nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

         -- Lesser used LSP functionality
         nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
         nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
         nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
         nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end, 'Workspace List Folders')

         nmap('<leader>ni', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { nil })
         end, 'Toggle inlay hints')

         if client.config.settings.codelens_enabled then
            nmap('<leader>cl', vim.lsp.codelens.run, 'Run CodeLens')
         end

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

      require('mason').setup()
      require('mason-lspconfig').setup()

      local servers = {
         volar = {},
         jsonls = {},
         pyright = {},
         rust_analyzer = {},
         html = { filetypes = { 'html', 'twig', 'hbs' } },
         cssls = {},
         marksman = {},
         tailwindcss = { filetypes = { 'html', 'twig', 'css', 'jsx', 'vue' } },
         gopls = {},
         intelephense = {
            codelens_enabled = true,
            intelephense = {
               codeLens = {
                  implementations = {
                     enable = true,
                  },
                  overrides = {
                     enable = true,
                  },
                  parent = {
                     enable = true,
                  },
                  references = {
                     enable = true,

                  },
                  usages = {
                     enable = true,
                  },
               },
            },
         },
         -- only for php 8.0+
         -- phpactor = {},
         kotlin_language_server = {},
         tsserver = {},
         lua_ls = {
            Lua = {
               workspace = { checkThirdParty = false },
               telemetry = { enable = false },
               hint = { enable = true },
            },
         },
      }

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
            'stylua',        -- lua formatter
            'eslint',        -- js/ts formatter/linter
            'php-cs-fixer',  -- php formatter
            'prettierd',     -- general formatter (markdown, json, etc)
            'markdownlint',  -- markdown linter
            'golangci-lint', -- go linter
            'phpcs',         -- php linter

            -- include in gopls lsp
            -- 'gofmt',
         },
      }

      mason_lspconfig.setup_handlers {
         function(server_name)
            lspconfig[server_name].setup {
               capabilities = capabilities,
               on_attach = on_attach,
               settings = servers[server_name],
               filetypes = (servers[server_name] or {}).filetypes,
            }
         end,
      }

      lspconfig['sourcekit'].setup {
         autostart = true,
         capabilities = capabilities,
         on_attach = on_attach,
         filetypes = { 'swift', 'objective-c', 'objective-cpp' },
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

      lspconfig['clangd'].setup {
         capabilities = capabilities,
         on_attach = on_attach,
         -- https://www.reddit.com/r/neovim/comments/12qbcua/multiple_different_client_offset_encodings/
         cmd = {
            'clangd',
            '--offset-encoding=utf-16',
         },
      }
   end,
}
