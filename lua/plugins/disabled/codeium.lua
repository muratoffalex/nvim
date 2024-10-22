return {
   'Exafunction/codeium.vim',
   event = 'BufEnter',
   enabled = false,
   config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<A-g>', function()
         return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<A-,>', function()
         return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true })
      vim.keymap.set('i', '<A-.>', function()
         return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true })
      vim.keymap.set('i', '<c-x>', function()
         return vim.fn['codeium#Clear']()
      end, { expr = true })
      vim.keymap.set('n', '<leader>cC', function()
         return vim.fn['codeium#Chat']()
      end, { expr = true, desc = "Chat", silent = true })
   end,
}
