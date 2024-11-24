return {
  'potamides/pantran.nvim',
  keys = {
    { '<leader>trr', desc = 'Translate line' },
    { '<leader>tr', desc = 'Translate selection', mode = { 'x', 'v' } },
  },
  config = function()
    local pantran = require 'pantran'
    pantran.setup {
      default_engine = 'google',
      engines = {
        google = {
          default_source = 'auto',
          -- not works
          default_target = 'ru',
          fallback = {
            -- works
            default_target = 'ru',
          },
        },
      },
    }
    local opts = { noremap = true, silent = true, expr = true }
    opts.desc = 'Translate line'
    vim.keymap.set('n', '<leader>trr', function()
      return pantran.motion_translate() .. '_'
    end, opts)
    opts.desc = 'Translate selection'
    vim.keymap.set('x', '<leader>tr', pantran.motion_translate, opts)
  end,
}
