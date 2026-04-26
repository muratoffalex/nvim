return {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  opts = {
    -- delete when fixed https://github.com/stevearc/oil.nvim/issues/483
    default_file_explorer = false,
    view_options = {
      show_hidden = false,
      is_always_hidden = function(name)
        return name == '.git'
          or name == 'node_modules'
          or name == '__pycache__'
          or name == '.DS_Store'
          or name == '.idea'
          or name == '.vscode'
      end,
    },
    float = {
      padding = 1,
      border = 'rounded',
    },
    keymaps = {
      ['q'] = { 'actions.close', mode = 'n' },
      ['gd'] = {
        desc = 'Toggle file detail view',
        callback = function()
          detail = not detail
          if detail then
            require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
          else
            require('oil').set_columns { 'icon' }
          end
        end,
      },
    },
  },
  dependencies = {
    'nvim-mini/mini.icons',
    {
      'JezerM/oil-lsp-diagnostics.nvim',
      dependencies = { 'stevearc/oil.nvim' },
      opts = {
        count = true,
      },
    },
    {
      'malewicz1337/oil-git.nvim',
      dependencies = { 'stevearc/oil.nvim' },
    },
  },
  config = function(_, opts)
    local oil = require 'oil'
    oil.setup(opts)
    vim.keymap.set('n', '<leader>e', function()
      if vim.startswith(vim.fn.bufname(), 'oil://') then
        oil.close()
        return
      else
        oil.open_float()
      end
    end, { silent = true, desc = 'Toggle oil' })
  end,
}
