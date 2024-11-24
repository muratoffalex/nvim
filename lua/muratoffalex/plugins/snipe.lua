return {
  'leath-dub/snipe.nvim',
  lazy = false,
  keys = {
    { 'tt', desc = 'Toggle buffer menu' },
  },
  priority = 10, -- because it needs to be loaded after dressing plugin
  opts = {
    ui = {
      position = 'cursor',
      max_path_width = 3,
    },
    sort = 'last',
    hints = {
      -- specified for colemak layout
      dictionary = 'arstdwfneiohmpg',
    },
  },
  config = function(_, opts)
    local snipe = require 'snipe'
    snipe.setup(opts)
    vim.keymap.set('n', 'tt', snipe.open_buffer_menu)

    snipe.ui_select_menu = require('snipe.menu'):new {
      position = opts.ui.position,
      dictionary = opts.hints.dictionary,
    }
    snipe.ui_select_menu:add_new_buffer_callback(function(m)
      local function close_menu()
        m:close()
      end
      vim.keymap.set('n', '<esc>', close_menu, { nowait = true, buffer = m.buf })
      vim.keymap.set('n', 'q', close_menu, { nowait = true, buffer = m.buf })
    end)
    vim.ui.select = snipe.ui_select
  end,
}
