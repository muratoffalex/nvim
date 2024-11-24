return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  keys = {
    -- NOTE: frequently used functionality, this more comfortable, but less mnemonic
    -- keymaps starting from <leader> (ex., <leader>D...) and zd not convenient for me
    { 'ghh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview file history' },
    { 'gho', '<cmd>DiffviewOpen<cr>', desc = 'Diffview open' },
    { 'ghc', '<cmd>DiffviewClose<cr>', desc = 'Diffview close' },
    { 'ght', '<cmd>DiffviewToggleFiles<cr>', desc = 'Diffview toggle files' },
  },
  opts = {
    show_help_hints = false,
  },
}
