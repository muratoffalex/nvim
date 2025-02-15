return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  keys = {
    {'<leader>tD', function()
      require('tiny-inline-diagnostic').toggle()
    end, desc = 'Toggle LSP Diagnostics'}
  },
  opts = {
    options = {
      multilines = true,
    },
  },
}
