return {
   'nvim-tree/nvim-tree.lua',
   enabled = false,
   version = '*',
   lazy = false,
   dependencies = {
      'nvim-tree/nvim-web-devicons',
   },
   keys = {
      { '<C-e>', '<cmd>NvimTreeToggle<cr>', desc = 'Neotree toggle' },
   },
   config = function()
      require('nvim-tree').setup {}
   end,
}
