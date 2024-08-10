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
         highlights.WinBarGreen = { fg = colors.green }
         highlights.WinBarRed = { fg = colors.red }
         highlights.WinBarBlue = { fg = colors.blue }
      end,
   },
   config = function(_, opts)
      require('tokyonight').setup(opts)

      -- apply on_highlights after start nvim
      vim.cmd.colorscheme 'tokyonight'
   end,
}
