return {
  'craftzdog/solarized-osaka.nvim',
  lazy = false,
  enabled = require('muratoffalex.config').theme == 'solirized-osaka',
  priority = 1000,
  opts = function()
    return {
      transparent = true,
    }
  end,
  config = function()
    vim.cmd.colorscheme 'solarized-osaka'
  end,
}
