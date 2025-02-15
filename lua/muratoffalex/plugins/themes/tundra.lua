return {
  'sam4llis/nvim-tundra',
  enabled = require('muratoffalex.config').theme == 'tundra',
  config = function()
    require('nvim-tundra').setup {
      transparent_background = true,
    }
    vim.opt.background = 'dark'
    vim.cmd.colorscheme 'tundra'
  end,
}
