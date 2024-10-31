-- disable, because use incline
return {
   'utilyre/barbecue.nvim',
   name = 'barbecue',
   version = '*',
   event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
   dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
   },
   config = function()
      require('barbecue').setup {
         create_autocmd = false,
         show_modified = true,
         custom_section = require('utils.init').git_status,
      }

      vim.api.nvim_create_autocmd({
         'WinResized',
         'BufWinEnter',
         'CursorHold',
         'InsertLeave',

         -- include this if you have set `show_modified` to `true`
         'BufModifiedSet',
      }, {
         group = vim.api.nvim_create_augroup('barbecue.updater', {}),
         callback = function()
            require('barbecue.ui').update()
         end,
      })
   end,
}
