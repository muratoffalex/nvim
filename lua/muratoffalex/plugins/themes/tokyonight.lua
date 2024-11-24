return {
  'folke/tokyonight.nvim',
  priority = 1000,
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
        AvanteConflictIncoming = { bg = '#93c47d' },
        AvanteConflictCurrent = { bg = '#f9bfbf' },
      }
      for k, v in pairs(diff_highlights) do
        highlights[k] = v
      end
    end,
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)

    -- apply on_highlights after start nvim
    vim.cmd.colorscheme 'tokyonight'
  end,
}
