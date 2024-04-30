return {
   'folke/which-key.nvim',
   config = function()
      -- document existing key chains
      require('which-key').register {
         ['<leader>c'] = { name = 'Code/Copilot', mode = { 'n', 'v' }, _ = 'which_key_ignore' },
         ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
         ['<leader>f'] = { name = 'Find/Format', mode = {'n', 'v'}, _ = 'which_key_ignore' },
         ['<leader>b'] = { name = 'Buffers', _ = 'which_key_ignore' },
         ['<leader>h'] = { name = 'Gitsigns', mode = {'n', 'v'}, _ = 'which_key_ignore' },
         ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
         ['<leader>m'] = { name = 'Map/Maximize', _ = 'which_key_ignore' },
         ['<leader>t'] = { name = 'Trouble/Tabs', _ = 'which_key_ignore' },
         ['<leader>u'] = { name = 'Autopairs', _ = 'which_key_ignore' },
         ['<leader>p'] = { name = 'Package.json deps', _ = 'which_key_ignore' },
         ['s'] = { name = 'Split windows', _ = 'which_key_ignore' },
         ['<leader>q'] = { name = 'Sessions', _ = 'which_key_ignore' },
         ['<leader>cn'] = { name = 'Toggle node under cursor', _ = 'which_key_ignore' },
         ['<leader>o'] = { name = 'Obsidian', mode = {'n', 'v'}, d = { name = '+Daily' }, _ = 'which_key_ignore' },
         ['<leader>cc'] = {
            name = '+CopilotChat',
            mode = { 'n', 'v' },
         },
         ['<leader>cx'] = {
            name = '+Xcodebuild',
         },
         ['<leader>r'] = {
            name = '+Refactoring',
            mode = { 'n', 'v' },
         },
         ['<leader>n'] = {
            name = '+Relative number/Wrap mode',
         },
      }
   end,
   opts = {},
}
