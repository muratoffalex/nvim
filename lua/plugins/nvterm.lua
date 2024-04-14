return {
   'NvChad/nvterm',
   lazy = true,
   keys = {
      {
         '<A-h>',
         function()
            require('nvterm.terminal').toggle 'horizontal'
         end,
         mode = { 'n', 't' },
      },
      {
         '<A-v>',
         function()
            require('nvterm.terminal').toggle 'vertical'
         end,
         mode = { 'n', 't' },
      },
      {
         '<A-f>',
         function()
            require('nvterm.terminal').toggle 'float'
         end,
         mode = { 'n', 't' },
      },
   },
   config = function()
      require('nvterm').setup()
   end,
}
