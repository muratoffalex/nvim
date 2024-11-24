return {
  'hedyhli/outline.nvim',
  keys = {
    { '<leader>O', desc = 'Toggle outline' },
  },
  cmd = { 'Outline' },
  config = function()
    vim.keymap.set('n', '<leader>O', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })

    require('outline').setup()
  end,
}
