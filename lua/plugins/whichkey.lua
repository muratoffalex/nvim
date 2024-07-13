return {
   'folke/which-key.nvim',
   opts = {
      icons = {
         rules = false,
      },
      spec = {
         -- document existing key chains
         -- TODO: mb put some chains to plugin files?
         { '<leader>b',  group = 'Buffers' },
         { '<leader>q',  group = 'Sessions' },
         { '<leader>cx', group = 'Xcodebuild' },
         { '<leader>d',  group = 'Document' },
         { '<leader>m',  group = 'Map/Maximize' },
         { '<leader>n',  group = 'Relative number/Wrap mode' },
         { '<leader>p',  group = 'Package.json deps' },
         { '<leader>t',  group = 'Trouble/Tabs' },
         { '<leader>w',  group = 'Workspace' },
         { 'gh',         group = 'Diffview' },
         { 'gs',         group = 'Mini.surround' },
         { '<leader>s',          group = 'Split windows' },
         {
            mode = { 'n', 'v' },
            { '<leader>c',  group = 'Code/Copilot' },
            { '<leader>f',  group = 'Find/Format' },
            { '<leader>h',  group = 'Gitsigns' },
            { '<leader>o',  group = 'Obsidian' },
            { '<leader>od', group = 'Daily' },
            { '<leader>r',  group = 'Refactoring' },
         },
      }
   },
}
