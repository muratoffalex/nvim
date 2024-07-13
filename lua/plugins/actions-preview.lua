return {
   'aznhe21/actions-preview.nvim',
   keys = {
      { '<leader>ca', mode = { 'n', 'v' }, function() require('actions-preview').code_actions() end, desc = 'Code actions' }
   }
}
