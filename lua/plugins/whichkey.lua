return {
   'folke/which-key.nvim',
   event = 'VeryLazy',
   keys = {
      {
         '<leader>?',
         function()
            require('which-key').show { global = false }
         end,
         desc = 'Buffer Local Keymaps (which-key)',
      },
   },
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
         { '<leader>t',  group = 'Trouble/Tabs/Translation' },
         { '<leader>w',  group = 'Workspace' },
         { 'gh',         group = 'Diffview' },
         { 'gs',         group = 'Mini.surround' },
         { '<leader>s',  group = 'Split windows' },
         {
            { '<leader>t',  group = 'Translation', mode = { 'x', 'v' } },
            { '<leader>tr', group = 'Translation' },
         },
         {
            mode = { 'n', 'v' },
            { '<leader>c',  group = 'Code/Copilot' },
            { '<leader>f',  group = 'Find/Format' },
            { '<leader>h',  group = 'Gitsigns' },
            { '<leader>o',  group = 'Obsidian' },
            { '<leader>od', group = 'Daily' },
            { '<leader>r',  group = 'Refactoring' },
         },
      },
   },
}
