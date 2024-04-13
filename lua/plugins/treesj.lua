return {
  'Wansmer/treesj',
  keys = {
    { '<leader>cnt', desc = 'Toggle node under cursor (split/join)' },
    { '<leader>cns', desc = 'Split node under cursor' },
    { '<leader>cnj', desc = 'Join node under cursor' },
    { '<leader>cnS', desc = 'Split node under cursor' },
    { '<leader>cnT', desc = 'Toggle node under cursor (split recursive/join)' },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local treesj = require 'treesj'
    treesj.setup {}

    vim.keymap.set('n', '<leader>cnT', function()
      treesj.toggle { split = { recursive = true } }
    end, { desc = 'Toggle node under cursor (split recursive/join)' })
    vim.keymap.set('n', '<leader>cnS', function()
      treesj.split { split = { recursive = true } }
    end, { desc = 'Split node under cursor' })

    vim.keymap.set('n', '<leader>cnt', treesj.toggle, { desc = 'Toggle node under cursor (split/join)' })
    vim.keymap.set('n', '<leader>cns', treesj.split, { desc = 'Split node under cursor' })
    vim.keymap.set('n', '<leader>cnj', treesj.join, { desc = 'Join node under cursor' })
  end,
}
