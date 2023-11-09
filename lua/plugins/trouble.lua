return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { '<leader>tt', "<cmd>lua require('trouble').toggle()<CR>", desc = 'Trouble toggle'},
    { '<leader>tw', "<cmd>lua require('trouble').toggle('workspace_diagnostics')<CR>", desc = 'Trouble toggle workspace diagnostic'},
    { '<leader>tc', "<cmd>lua require('trouble').toggle('document_diagnostics')<CR>", desc = 'Trouble toggle document diagnostic'},
    { '<leader>tq', "<cmd>lua require('trouble').toggle('quickfix')<CR>", desc = 'Trouble toggle quickfix list'},
    { '<leader>tl', "<cmd>lua require('trouble').toggle('loclist')<CR>", desc = 'Trouble toggle loclist'},
    { 'gr', "<cmd>lua require('trouble').toggle('lsp_references')<CR>", desc = 'Trouble lsp references'},
    { 'gi', "<cmd>lua require('trouble').toggle('lsp_implementations')<CR>", desc = 'Trouble lsp implementations'},
    { '<leader>q', "<cmd>lua require('trouble').toggle('loclist')<CR>", desc = 'Trouble toggle loclist'},
  },
  opts = {},
}
