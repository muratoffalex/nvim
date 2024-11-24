return {
  'rachartier/tiny-code-action.nvim',
  enabled = false,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
  },
  event = 'LspAttach',
  keys = {
    {
      '<leader>ca',
      mode = { 'n', 'v' },
      function()
        require('tiny-code-action').code_action()
      end,
      desc = 'Code actions',
    },
  },
  config = function()
    require('tiny-code-action').setup()
  end,
}
