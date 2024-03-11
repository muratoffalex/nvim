-- todo main config
local M = {}

M.icons = {
  git = {
    added = '',
    changed = '',
    copied = '',
    deleted = '',
    ignored = '',
    renamed = '',
    staged = '',
    unmerged = '',
    unstaged = '',
    untracked = '',
  },
  diagnostics = {
    error = ' ',
    warn = ' ',
    hint = ' ',
    info = ' ',
  },
}

M.current_theme = 'light'

return M
