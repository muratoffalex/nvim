return {
  {
    -- TODO: contribute and change
    'muratoffalex/dressing.nvim',
    branch = "feat/snipe-select-backend",
    dependencies = 'leath-dub/snipe.nvim',
    opts = {
      select = {
        enabled = true,
        backend = 'snipe',
        snipe = {
          options = {
            default_keymaps = {
              cancel = { '<esc>', 'q' },
            },
          },
        },
      },
    },
  },
  {
    -- TODO: contribute and change
    'muratoffalex/snipe.nvim',
    branch = "pagination",
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
        max_height = 15,
        subtitle = {
          format = '%pagination%%total_items% items',
        },
        pagination = {
          -- format = "[%page%/%total_pages%] ",
          format = function(vars)
            if vars.total_pages == 1 then
              return ''
            end
            return string.format('[%d/%d] %d items', vars.page, vars.total_pages, vars.total_items)
          end,
        },
        text_align = 'left',
      },
      navigate = {
        next_page = ']',
        prev_page = '[',
        cancel_snipe = { '<esc>', 'q' },
      },
      sort = 'last',
      hints = {
        -- specified for colemak layout
        dictionary = 'arstdwfneiohmpg',
      },
    },
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
