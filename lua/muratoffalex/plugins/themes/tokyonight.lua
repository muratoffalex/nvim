return {
  'folke/tokyonight.nvim',
  priority = 1000,
  lazy = require('muratoffalex.config').theme ~= 'tokyonight',
  opts = {
    transparent = false,
    style = 'night',
    light_style = 'day',
    styles = {
      sidebars = 'normal',
    },
    on_highlights = function(highlights, colors)
      local diff_highlights = {
        WinBarDiffAdded = { fg = colors.green },
        WinBarDiffRemoved = { fg = colors.red },
        WinBarDiffChanged = { fg = colors.blue },
      }
      for k, v in pairs(diff_highlights) do
        highlights[k] = v
      end
    end,
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme 'tokyonight'
  end,
}
