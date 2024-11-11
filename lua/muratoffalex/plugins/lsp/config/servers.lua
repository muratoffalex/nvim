local util = require 'lspconfig.util'

---@class LspServerConfig
---@field enabled boolean|nil
---@field auto_install boolean|nil
---@field disabled_formatter boolean|nil
---@field lspconfig_settings lspconfig.Config|nil
---@field setup function|nil

---@type table<string, LspServerConfig>
return {
   volar = {
      disabled_formatter = true,
   },
   jsonls = {},
   pyright = {},
   rust_analyzer = {},
   html = {
      lspconfig_settings = {
         filetypes = { 'html', 'twig', 'hbs' },
      },
   },
   cssls = {},
   marksman = {},
   tailwindcss = {
      lspconfig_settings = {
         filetypes = { 'html', 'twig', 'css', 'jsx', 'vue' },
      },
   },
   gopls = {},
   intelephense = {
      disabled_formatter = true,
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
   ts_ls = {
      disabled_formatter = true,
   },
   lua_ls = {
      disabled_formatter = true,
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
   sourcekit = {
      auto_install = false,
      lspconfig_settings = {
         filetypes = { 'swift', 'objective-c', 'objective-cpp' },
         autostart = false,
         cmd = { vim.trim(vim.fn.system 'xcrun -f sourcekit-lsp') },
         ---@return string|nil
         root_dir = function(filename, _)
            return util.root_pattern 'buildServer.json' (filename)
                or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
                or util.find_git_ancestor(filename)
                or util.root_pattern 'Package.swift' (filename)
         end,
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
   clangd = {
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
