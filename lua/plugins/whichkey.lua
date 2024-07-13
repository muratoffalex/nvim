return {
   'folke/which-key.nvim',
   config = function()
      -- document existing key chains
      -- TODO: mb put some chains to plugin files?
      require('which-key').add {
         { '<leader>b',  group = 'Buffers' },
         { '<leader>cn', group = 'Toggle node under cursor' },
         { '<leader>cx', group = 'Xcodebuild' },
         { '<leader>d',  group = 'Document' },
         { '<leader>m',  group = 'Map/Maximize' },
         { '<leader>n',  group = 'Relative number/Wrap mode' },
         { '<leader>p',  group = 'Package.json deps' },
         { '<leader>q',  group = 'Sessions' },
         { '<leader>t',  group = 'Trouble/Tabs' },
         { '<leader>u',  group = 'Autopairs' },
         { '<leader>w',  group = 'Workspace' },
         { 'gh',         group = 'Diffview' },
         { 'gs',         group = 'Mini.surround' },
         { 's',          group = 'Split windows' },
         {
            mode = { 'n', 'v' },
            { '<leader>c',  group = 'Code/Copilot' },
            { '<leader>cc', group = 'CopilotChat' },
            { '<leader>f',  group = 'Find/Format' },
            { '<leader>h',  group = 'Gitsigns' },
            { '<leader>o',  group = 'Obsidian' },
            { '<leader>od', group = 'Daily' },
            { '<leader>r',  group = 'Refactoring' },
         },
      }
   end,
   opts = {},
}
