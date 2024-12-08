return {
  {
    'stevearc/dressing.nvim',
    dependencies = 'leath-dub/snipe.nvim',
    opts = {
      select = {
        enabled = true,
        backend = 'snipe',
      },
    },
  },
  {
    'leath-dub/snipe.nvim',
    keys = {
      {
        'tt',
        function()
          require('snipe').open_buffer_menu()
        end,
        desc = 'Toggle buffer menu',
      },
    },
    opts = {
      ui = {
        position = 'cursor',
      },
      sort = 'last',
      hints = {
        -- specified for colemak layout
        dictionary = 'arstdwfneiohmpg',
      },
    }
  },
  {
    'kungfusheep/snipe-spell.nvim',
    dependencies = 'leath-dub/snipe.nvim',
    config = true,
    keys = {
      { '<leader>sc', '<cmd>SnipeSpell<cr>', desc = 'Snipe Spellchecker' },
    },
  },
}
