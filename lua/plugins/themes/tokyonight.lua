return {
   'folke/tokyonight.nvim',
   lazy = false,
   enabled = true,
   priority = 1000,
   opts = function()
      return {
         transparent = false,
         style = 'storm',
         light_style = 'day',
         styles = {
            sidebars = 'normal',
         }
      }
   end,
}
