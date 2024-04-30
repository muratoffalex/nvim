return {
   'aznhe21/actions-preview.nvim',
   config = function()
      vim.keymap.set({ 'v', 'n' }, '<leader>ca', require('actions-preview').code_actions)
      require('which-key').register({ ['<leader>ca'] = 'Code actions' }, { mode = {'n', 'v'} })
   end,
}
