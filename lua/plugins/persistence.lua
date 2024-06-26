return {
   'folke/persistence.nvim',
   event = 'BufReadPre',
   opts = {
      options = vim.opt.sessionoptions:get(),
      pre_save = function()
         vim.cmd 'silent! Neotree close'
         vim.cmd 'silent! DBUIClose'
         vim.cmd 'silent! TroubleClose'
         vim.cmd 'silent! OutlineClose'
         vim.cmd 'silent! CopilotChatClose'
         vim.cmd 'silent! DiffviewClose'
         vim.cmd 'silent! lua require("nvterm.terminal").close_all_terms()'
      end, -- a function to call before saving the session
      save_empty = false, -- don't save if there are no open file buffers
   },
  -- stylua: ignore
  keys = {
    { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
  },
}
