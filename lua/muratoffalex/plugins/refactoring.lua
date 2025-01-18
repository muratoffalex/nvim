return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  lazy = true,
  keys = {
    { '<leader>re', mode = { 'x' }, desc = 'Refactor extract' },
    { '<leader>rf', mode = { 'x' }, desc = 'Refactor extract_to_file' },
    { '<leader>rr', mode = { 'x' }, desc = 'Refactor refactors' },
    { '<leader>rv', mode = { 'n', 'x' }, desc = 'Refactor extract_var' },
    { '<leader>ri', mode = { 'n' }, desc = 'Refactor inline_var' },
    { '<leader>rI', mode = { 'n' }, desc = 'Refactor inline_func' },
    { '<leader>rb', mode = { 'n' }, desc = 'Refactor extract_block' },
    { '<leader>rbf', mode = { 'n' }, desc = 'Refactor extract_block_to_file' },
  },
  config = function(_, opts)
    require('refactoring').setup(opts)

    vim.keymap.set('x', '<leader>re', ':Refactor extract ')
    vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ')

    vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ')

    vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var')

    vim.keymap.set('n', '<leader>rI', ':Refactor inline_func')

    vim.keymap.set('n', '<leader>rb', ':Refactor extract_block')
    vim.keymap.set('n', '<leader>rbf', ':Refactor extract_block_to_file')
  end,
}
