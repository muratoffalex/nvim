local util = require 'lspconfig.util'

local LSP = require 'muratoffalex.plugins.lsp.config.servers'

local function client_capabilities()
   local base_capabilities = vim.lsp.protocol.make_client_capabilities()
   local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

   return vim.tbl_deep_extend('force', base_capabilities, cmp_capabilities, {
      -- https://www.reddit.com/r/neovim/comments/1gdkrtn/i_want_to_use_neovim_but_the_lspintellisense_just/
      workspace = {
         didChangeWatchedFiles = { dynamicRegistration = false },
      },
   })
end

local M = {}

---TODO: add property like enabled_formatter to LspServerConfig
---@return string[]
M.excluded_formatters = {
   LSP.VOLAR,
   LSP.INTELEPHENSE,
   LSP.TS_LS,
   LSP.LUA_LS,
}

---@class LspServerConfig
---@field enabled boolean|nil
---@field auto_install boolean|nil
---@field lspconfig_settings lspconfig.Config|nil
---@field setup function|nil

---@return table<string, LspServerConfig>
M.lsp_servers = {
   [LSP.VOLAR] = {
      lspconfig_settings = {
         settings = {
            init_options = {
               vue = {
                  hybridMode = true,
               },
            },
         },
      },
   },
   [LSP.JSONLS] = {},
   [LSP.PYRIGHT] = {},
   [LSP.RUST_ANALYZER] = {},
   [LSP.HTML] = {
      lspconfig_settings = {
         filetypes = { 'html', 'twig', 'hbs' },
      },
   },
   [LSP.CSSLS] = {},
   [LSP.MARKSMAN] = {},
   [LSP.TAILWINDCSS] = {
      lspconfig_settings = {
         filetypes = { 'html', 'twig', 'css', 'jsx', 'vue' },
         on_attach = function(_, _) end,
      },
   },
   [LSP.GOPLS] = {},
   [LSP.INTELEPHENSE] = {
      lspconfig_settings = {
         settings = {
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
      },
   },
   -- only for php 8.0+
   -- phpactor = {},
   -- kotlin_language_server = {},
   [LSP.TS_LS] = {},
   [LSP.LUA_LS] = {
      lspconfig_settings = {
         settings = {
            Lua = {
               workspace = { checkThirdParty = false },
               telemetry = { enable = false },
               hint = { enable = true },
            },
         },
      },
   },
   [LSP.SOURCEKIT] = {
      auto_install = false,
      lspconfig_settings = {
         filetypes = { 'swift', 'objective-c', 'objective-cpp' },
         autostart = false,
         cmd = { vim.trim(vim.fn.system 'xcrun -f sourcekit-lsp') },
         ---@return string|nil
         root_dir = function(filename, _)
            return util.root_pattern 'buildServer.json'(filename)
               or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
               or util.find_git_ancestor(filename)
               or util.root_pattern 'Package.swift'(filename)
         end,
         -- https://www.swift.org/documentation/articles/zero-to-swift-nvim.html
         capabilities = vim.tbl_deep_extend('force', client_capabilities(), {
            workspace = {
               didChangeWatchedFiles = { dynamicRegistration = true },
            },
         }),
      },
      setup = function()
         local group = vim.api.nvim_create_augroup('SourcekitAutostart', { clear = true })
         vim.api.nvim_create_autocmd({ 'BufEnter', 'LspDetach' }, {
            group = group,
            callback = function()
               if vim.bo.filetype == 'swift' and #(vim.lsp.get_clients { name = 'sourcekit' }) == 0 then
                  vim.cmd 'LspStart'
               end
            end,
            desc = 'Start sourcekit on swift files if not already started (enter file or lsp crashed)',
         })
      end,
   },
   [LSP.CLANGD] = {
      lspconfig_settings = {
         filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
         -- https://www.reddit.com/r/neovim/comments/12qbcua/multiple_different_client_offset_encodings/
         cmd = {
            'clangd',
            '--offset-encoding=utf-16',
         },
      },
   },
}

---@return table<string, LspServerConfig>
M.active_lsp_servers = function()
   local active = {}
   for name, config in pairs(M.lsp_servers) do
      if config.enabled ~= false then
         active[name] = config
      end
   end
   return active
end

---@return string[]
M.ensure_installed = function()
   local servers = M.active_lsp_servers()
   local ensure = {}

   for server_name, config in pairs(servers) do
      if config.auto_install ~= false then
         table.insert(ensure, server_name)
      end
   end

   return ensure
end

M.format_lspconfig_settings = function(settings)
   local default_opts = {
      capabilities = M.client_capabilities,
      on_attach = M.on_attach,
   }
   local formatted = vim.tbl_deep_extend('force', default_opts, settings or {})

   return formatted
end

M.setup_lsp_servers = function(lspconfig)
   local servers = M.active_lsp_servers()
   for server_name, _ in pairs(servers) do
      local server = servers[server_name] or {}

      lspconfig[server_name].setup(M.format_lspconfig_settings(server.lspconfig_settings))

      if server.setup then
         server.setup()
      end
   end
end

M.client_capabilities = client_capabilities()

M.format_action = function(opts)
   local bufnr = type(opts) == 'number' and opts or type(opts) == 'table' and opts.buf or vim.api.nvim_get_current_buf()

   local function format_buffer()
      vim.lsp.buf.format {
         bufnr = bufnr,
         -- some tools (like eslint) are slow
         timeout_ms = 5000,
         filter = function(c)
            return not vim.tbl_contains(M.excluded_formatters, c.name)
         end,
      }
   end

   -- Execute with error handling
   local ok, err = pcall(format_buffer)
   if not ok then
      vim.notify('Format failed: ' .. tostring(err), vim.log.levels.ERROR)
   end
end

M.on_attach = function(client, bufnr)
   -- for inline diagnostic messages, use tiny-inline-diagnostic instead
   vim.diagnostic.config { virtual_text = false }

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

   nmap('<leader>ca', vim.lsp.buf.code_action, 'Code actions')

   nmap('<leader>ni', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { nil })
   end, 'Toggle inlay hints')

   if client.config.settings.codelens_enabled then
      nmap('<leader>cl', vim.lsp.codelens.run, 'Run CodeLens')
   end

   -- disable formatting
   -- client.resolved_capabilities.document_formatting = false
   -- Create a command `:Format` local to the LSP buffer
   vim.api.nvim_buf_create_user_command(bufnr, 'Format', M.format_action, { desc = 'Format current buffer with LSP' })
end

return M
