return {
   'folke/trouble.nvim',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   cmd = 'Trouble',
   keys = {
      { '<leader>tg', "<cmd>Trouble toggle<CR>", desc = 'Trouble toggle' },
      { '<leader>tw', "<cmd>Trouble diagnostics toggle<CR>", desc = 'Trouble toggle workspace diagnostic' },
      { '<leader>tc', "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = 'Trouble toggle document diagnostic' },
      { '<leader>tq', "<cmd>Trouble qflist toggle<CR>", desc = 'Trouble toggle quickfix list' },
      { '<leader>tl', "<cmd>Trouble loclist toggle<CR>", desc = 'Trouble toggle loclist' },
      { 'gr', "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = 'Trouble lsp references/definitions/...' },
      -- { 'gi', "<cmd>lua require('trouble').toggle('lsp_implementations')<CR>", desc = 'Trouble lsp implementations' },
   },
   opts = {},
}
