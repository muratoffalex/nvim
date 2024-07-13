return {
   'folke/persistence.nvim',
   event = 'BufReadPre',
   opts = {
      dir = vim.fn.stdpath 'state' .. '/sessions/',
      need = 1,
      branch = true, -- use git branch to save session
      pre_save = function()
         vim.cmd 'silent! Neotree close'
         vim.cmd 'silent! DBUIClose'
         vim.cmd 'silent! TroubleClose'
         vim.cmd 'silent! OutlineClose'
         vim.cmd 'silent! CopilotChatClose'
         vim.cmd 'silent! DiffviewClose'
         vim.cmd 'silent! lua require("nvterm.terminal").close_all_terms()'
      end, -- a function to call before saving the session
   },
   -- stylua: ignore
   keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,              desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
   },
}
