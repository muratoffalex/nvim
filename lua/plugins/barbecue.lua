return {
   'utilyre/barbecue.nvim',
   name = 'barbecue',
   version = '*',
   event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
   dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
   },
   opts = {},
}
