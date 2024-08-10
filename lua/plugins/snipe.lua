return {
   'leath-dub/snipe.nvim',
   keys = {
      { 'tt', desc = 'Toggle buffer menu' },
   },
   opts = {
      ui = {
         position = 'cursor',
      },
      sort = 'last',
      hints = {
         -- specified for colemak layout
         dictionary = 'sartdwfneiohmpg',
      },
   },
   config = function(_, opts)
      local snipe = require 'snipe'
      snipe.setup(opts)
      vim.keymap.set('n', 'tt', snipe.create_buffer_menu_toggler { max_path_width = 3 })
   end,
}
