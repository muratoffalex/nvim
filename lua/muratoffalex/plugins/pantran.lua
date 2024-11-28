return {
  'muratoffalex/pantran.nvim',
  -- TODO: default alternate target for fallback google engine
  branch = 'develop',
  keys = {
    { '<leader>trr', desc = 'Translate line' },
    { '<leader>tr', desc = 'Translate selection', mode = { 'x', 'v' } },
  },
  opts = {
    default_engine = 'google',
    engines = {
      google = {
        default_source = 'auto',
        fallback = {
          default_target = 'ru',
          default_alternate_target = 'en',
        },
      },
    },
  },
  config = function(_, opts)
    local pantran = require 'pantran'
    pantran.setup(opts)

    local keymap_opts = { noremap = true, silent = true, expr = true }
    keymap_opts.desc = 'Translate line'
    vim.keymap.set('n', '<leader>trr', function()
      return pantran.motion_translate() .. '_'
    end, keymap_opts)
    keymap_opts.desc = 'Translate selection'
    vim.keymap.set('x', '<leader>tr', pantran.motion_translate, keymap_opts)
  end,
}
