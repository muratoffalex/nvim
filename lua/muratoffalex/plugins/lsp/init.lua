local userConfig = require 'muratoffalex.config'

return {
  'neovim/nvim-lspconfig',
  dependencies = userConfig.current_os ~= 'nixos' and {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'saghen/blink.cmp',
  } or {
    'saghen/blink.cmp',
  },
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  opts = {
    codelens = {
      enabled = true,
    },
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local config = require 'muratoffalex.plugins.lsp.config'

    if userConfig.current_os ~= 'nixos' then
      local mason_lspconfig = require 'mason-lspconfig'
      require('mason').setup()
      mason_lspconfig.setup {
        automatic_installation = true,
        ensure_installed = config.ensure_installed(),
      }
    end

    config.setup_lsp_servers(lspconfig)
  end,
}
