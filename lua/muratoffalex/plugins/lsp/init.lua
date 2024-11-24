return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
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
    local mason_lspconfig = require 'mason-lspconfig'
    local config = require 'muratoffalex.plugins.lsp.config'

    require('mason').setup()

    mason_lspconfig.setup {
      ensure_installed = config.ensure_installed(),
    }

    config.setup_lsp_servers(lspconfig)
  end,
}
