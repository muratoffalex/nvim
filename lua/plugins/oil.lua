return {
   'stevearc/oil.nvim',
   opts = {
      view_options = {
         show_hidden = true,
         is_always_hidden = function(name)
            return name == '.git' or name == 'node_modules' or name == '__pycache__' or name == '.DS_Store' or name == '.idea' or name == '.vscode'
         end,
      },
   },
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   config = function(_, opts)
      require('oil').setup(opts)
      vim.keymap.set('n', '<leader>E', function()
         if vim.startswith(vim.fn.bufname(), 'oil://') then
            vim.cmd 'bd'
         else
            vim.cmd 'Oil'
         end
      end, { silent = true, desc = 'Toggle oil' })
   end,
}
