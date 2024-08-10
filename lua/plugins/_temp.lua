return {
   {
      'barrett-ruth/live-server.nvim',
      build = 'npm add -g live-server',
      cmd = { 'LiveServerStart', 'LiveServerStop' },
      config = true,
   },
   {
      'echasnovski/mini.files',
      version = '*',
   },
   {
      'ibhagwan/fzf-lua',
      -- optional for icon support
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
         -- calling `setup` is optional for customization
         -- TODO: git_icons = true
         require('fzf-lua').setup {}
      end,
   },
   {
      'potamides/pantran.nvim',
      keys = {
         { '<leader>trr', desc = 'Translate line' },
         { '<leader>tr',  desc = 'Translate selection', mode = { 'x', 'v' } },
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
   },
   {
      'adalessa/laravel.nvim',
      dependencies = {
         'nvim-telescope/telescope.nvim',
         'tpope/vim-dotenv',
         'MunifTanjim/nui.nvim',
         'nvimtools/none-ls.nvim',
      },
      cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
      keys = {
         { '<leader>la', ':Laravel artisan<cr>' },
         { '<leader>lr', ':Laravel routes<cr>' },
         { '<leader>lm', ':Laravel related<cr>' },
      },
      event = { 'VeryLazy' },
      config = true,
   }
}
