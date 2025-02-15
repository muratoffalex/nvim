return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  enabled = require('muratoffalex.config').theme == 'catppuccin',
  config = function()
    -- vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
