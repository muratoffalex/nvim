return {
  'stevearc/oil.nvim',
  enabled = false,
  opts = {
    -- delete when fixed https://github.com/stevearc/oil.nvim/issues/483
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name)
        return name == '.git'
          or name == 'node_modules'
          or name == '__pycache__'
          or name == '.DS_Store'
          or name == '.idea'
          or name == '.vscode'
      end,
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function(_, opts)
    local oil = require 'oil'
    oil.setup(opts)
    vim.keymap.set('n', '<leader>E', function()
      if vim.startswith(vim.fn.bufname(), 'oil://') then
        oil.close()
      else
        oil.open()
      end
    end, { silent = true, desc = 'Toggle oil' })
  end,
}
