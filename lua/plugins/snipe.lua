return {
   'leath-dub/snipe.nvim',
   keys = {
      { 'tt', desc = 'Toggle buffer menu' },
   },
   config = function()
      local snipe = require 'snipe'
      snipe.setup {
         ui = {
            position = 'cursor',
         },
      }
      vim.keymap.set('n', 'tt', snipe.create_buffer_menu_toggler { max_path_width = 3 })
   end,
}
