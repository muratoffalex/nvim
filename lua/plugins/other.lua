return {
   -- Detect tabstop and shiftwidth automatically
   'tpope/vim-sleuth',
   -- "gc" to comment visual regions/lines
   {
      'numToStr/Comment.nvim',
      event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
      config = function()
         require('Comment').setup {
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
         }
      end,
   },
   { 'echasnovski/mini.bufremove', version = '*' },
}
