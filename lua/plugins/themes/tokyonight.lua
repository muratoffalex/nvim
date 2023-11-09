return {
  "folke/tokyonight.nvim",
  lazy = false,
  enable = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme 'tokyonight-storm'
  end
}
