return {
   'utilyre/barbecue.nvim',
   name = 'barbecue',
   version = '*',
   event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
   dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
   },
   opts = {
      create_autocmd = false,
      show_modified = true,
   },
   config = function(_, opts)
      require('barbecue').setup(opts)

      vim.api.nvim_create_autocmd({
        "WinResized",
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
   end,
}
