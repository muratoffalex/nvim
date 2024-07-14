return {
   'folke/persistence.nvim',
   event = 'BufReadPre',
   opts = {
      dir = vim.fn.stdpath 'state' .. '/sessions/',
      need = 1,
      branch = true,
   },
   -- stylua: ignore
   keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,              desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
   },
}
