return {
  'olimorris/codecompanion.nvim',
  cmd = {
    'CodeCompanion',
    'CodeCompanionActions',
    'CodeCompanionChat',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
  },
  config = true,
}
