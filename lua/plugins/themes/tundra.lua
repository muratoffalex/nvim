return {
   'sam4llis/nvim-tundra',
   enabled = false,
   config = function()
      require('nvim-tundra').setup {
         transparent_background = true,
      }
      vim.opt.background = 'dark'
      vim.cmd.colorscheme 'tundra'
   end,
}
