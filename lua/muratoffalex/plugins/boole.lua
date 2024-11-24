return {
  'nat-418/boole.nvim',
  event = 'BufEnter',
  config = function()
    require('boole').setup {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
      additions = {
        { 'tic', 'tac', 'toe' },
        { 'var', 'let' },
      },
      allow_caps_additions = {
        { 'enable', 'disable' },
        -- enable → disable
        -- Enable → Disable
        -- ENABLE → DISABLE
      },
    }
  end,
}
