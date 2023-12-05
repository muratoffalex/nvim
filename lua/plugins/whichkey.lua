return {
  'folke/which-key.nvim',
  config = function()
    -- document existing key chains
    require('which-key').register {
      ['<leader>c'] = { name = 'Code/Copilot', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
      ['<leader>b'] = { name = 'Buffers', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = 'Gitsigns', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
      ['<leader>z'] = { name = 'Fold', _ = 'which_key_ignore' },
      ['<leader>m'] = { name = 'Map/Maximize', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = 'Trouble', _ = 'which_key_ignore' },
      ['<leader>u'] = { name = 'Autopairs', _ = 'which_key_ignore' },
      ['<leader>p'] = { name = 'Package.json deps', _ = 'which_key_ignore' },
      ['s'] = { name = 'Split windows', _ = 'which_key_ignore' },
      ['<leader>q'] = { name = 'Sessions', _ = 'which_key_ignore' },
    }
  end,
  opts = {}
}
