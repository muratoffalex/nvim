return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  enabled = true,
  lazy = true,
  cmd = {
    'DBUI',
    'DBUIClose',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  keys = {
    { '<leader>db', '<cmd>DBUIToggle<cr>', desc = 'Open DBUI' },
  },
  config = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    -- NOTE: Noice.nvim notify overlap this in right position
    -- vim.g.db_ui_win_position = 'right'
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_use_nvim_notify = 1
    vim.g.db_ui_show_help = 0

    local cmp = require 'cmp'

    local autocomplete_group = vim.api.nvim_create_augroup('vimrc_autocompletion', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'sql', 'mysql', 'plsql' },
      callback = function()
        cmp.setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
      end,
      group = autocomplete_group,
    })
  end,
}
