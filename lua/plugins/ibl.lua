return {
   'lukas-reineke/indent-blankline.nvim',
   event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
   opts = {
      indent = {
         char = '│',
         tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
         filetypes = {
            'help',
            'alpha',
            'dashboard',
            'neo-tree',
            'Trouble',
            'trouble',
            'lazy',
            'mason',
            'notify',
            'toggleterm',
            'lazyterm',
         },
      },
   },
   main = 'ibl',
}
-- return {
--   -- Add indentation guides even on blank lines
--   'lukas-reineke/indent-blankline.nvim',
--   -- Enable `lukas-reineke/indent-blankline.nvim`
--   -- See `:help ibl`
--   version = '2.20.7',
--   -- main = 'ibl',
--   opts = {
--     indentLine_enabled = 1,
--     filetype_exclude = {
--       'help',
--       'terminal',
--       'lazy',
--       'lspinfo',
--       'TelescopePrompt',
--       'TelescopeResults',
--       'mason',
--       '',
--     },
--     buftype_exclude = { 'terminal' },
--     -- show_trailing_blankline_indent = false,
--     -- show_first_indent_level = false,
--     -- show_current_context = true,
--     -- show_current_context_start = true,
--   },
-- }
