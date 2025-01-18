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
    'ibhagwan/fzf-lua', -- Optional: For using slash commands
  },
  config = true,
}
