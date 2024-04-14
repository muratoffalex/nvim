return {
   'charludo/projectmgr.nvim',
   enabled = false,
   keys = {
      { '<leader>pp', '<cmd>ProjectMgr<cr>', desc = 'Open project manager' },
   },
   config = function()
      require('projectmgr').setup {
         -- autogit = {
         --   enabled = true,
         --   command = "git pull --ff-only > .git/fastforward.log 2>&1",
         -- },
         session = { enabled = true, file = '.git/Session.vim' },
         reopent = true,
      }
   end,
}
