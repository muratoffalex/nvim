return {
  'christoomey/vim-tmux-navigator',
  event = 'VeryLazy',
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    -- vim.g.tmux_navigator_no_dynamic_title = 1
    -- vim.g.tmux_navigator_save_on_switch = 1
    -- vim.g.tmux_navigator_disable_when_zoomed = 1
    -- vim.g.tmux_navigator_preserve_zoom = 1

    vim.keymap.set('n', '<M-n>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<M-e>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<M-i>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<M-o>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<M-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true })
  end,
}
