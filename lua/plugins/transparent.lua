return {
   'xiyaowong/transparent.nvim',
   enabled = true,
   config = function()
      require('transparent').clear_prefix 'Bufferline'
      -- require('transparent').clear_prefix('lualine')
      require('transparent').clear_prefix 'NeoTree'
      require('transparent').clear_prefix 'Trouble'
   end,
}
