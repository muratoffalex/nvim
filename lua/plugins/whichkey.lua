return {
   'folke/which-key.nvim',
   config = function()
      -- document existing key chains
      -- TODO: mb put some chains to plugin files?
      require('which-key').register {
         ['<leader>c'] = { name = 'Code/Copilot', mode = { 'n', 'v' } },
         ['<leader>d'] = { name = 'Document' },
         ['<leader>f'] = { name = 'Find/Format', mode = { 'n', 'v' } },
         ['<leader>b'] = { name = 'Buffers' },
         ['<leader>h'] = { name = 'Gitsigns', mode = { 'n', 'v' } },
         ['<leader>w'] = { name = 'Workspace' },
         ['<leader>m'] = { name = 'Map/Maximize' },
         ['<leader>t'] = { name = 'Trouble/Tabs' },
         ['<leader>u'] = { name = 'Autopairs' },
         ['<leader>p'] = { name = 'Package.json deps' },
         ['s'] = { name = 'Split windows' },
         ['<leader>q'] = { name = 'Sessions' },
         ['<leader>cn'] = { name = 'Toggle node under cursor' },
         ['<leader>o'] = { name = 'Obsidian', mode = { 'n', 'v' }, d = { name = '+Daily' } },
         ['<leader>cc'] = { name = '+CopilotChat', mode = { 'n', 'v' } },
         ['<leader>cx'] = { name = '+Xcodebuild' },
         ['<leader>r'] = { name = '+Refactoring', mode = { 'n', 'v' } },
         ['<leader>n'] = { name = '+Relative number/Wrap mode' },
         ['gh'] = { name = '+Diffview' },
         ['gs'] = { name = '+Mini.surround' },
      }
   end,
   opts = {},
}
