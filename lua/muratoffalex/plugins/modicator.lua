return {
  'mawkler/modicator.nvim',
  dependencies = 'folke/tokyonight.nvim',
  init = function()
    -- These are required for Modicator to work
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  opts = {
    highlights = {
      defaults = {
        bold = true,
        italic = false,
      },
      use_cursorline_background = false,
    },
  },
}
