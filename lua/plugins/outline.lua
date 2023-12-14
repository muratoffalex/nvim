return {
  'hedyhli/outline.nvim',
  keys = {
    { '<leader>o', desc = 'Toggle outline' },
  },
  cmd = { 'Outline' },
  config = function()
    vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })

    require('outline').setup()
  end,
}
