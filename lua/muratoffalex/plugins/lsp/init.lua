return {
   'neovim/nvim-lspconfig',
   dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
   },
   event = 'VeryLazy',
   opts = {
      codelens = {
         enabled = true,
      },
   },
   config = function()
      local lspconfig = require 'lspconfig'
      local mason_lspconfig = require 'mason-lspconfig'
      local config = require 'muratoffalex.plugins.lsp.config'

      require('mason').setup()

      mason_lspconfig.setup {
         ensure_installed = config.ensure_installed(),
      }

      local servers = config.active_lsp_servers()
      local on_attach = config.on_attach
      local capabilities = config.client_capabilities()
      for server_name, _ in pairs(servers) do
         local server = servers[server_name] or {}

         local default_opts = {
            capabilities = capabilities,
            on_attach = on_attach,
         }

         local opts = vim.tbl_deep_extend('force', default_opts, server.lspconfig_settings or {})

         lspconfig[server_name].setup(opts)

         if server.setup then
            server.setup()
         end
      end
   end,
}
