return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-mini/mini.icons' },
  cmd = 'Trouble',
  keys = {
    { '<leader>tg', '<cmd>Trouble toggle<CR>', desc = 'Trouble toggle' },
    { '<leader>tw', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Trouble toggle workspace diagnostic' },
    { '<leader>tc', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Trouble toggle document diagnostic' },
    { '<leader>tq', '<cmd>Trouble qflist toggle<CR>', desc = 'Trouble toggle quickfix list' },
    { '<leader>tl', '<cmd>Trouble loclist toggle<CR>', desc = 'Trouble toggle loclist' },
    {
      'grr',
      '<cmd>Trouble lsp toggle focus=false win.position=bottom<CR>',
      desc = 'Trouble lsp references/definitions/...',
    },
  },
  opts = {},
}
