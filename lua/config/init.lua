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

M.background = os.getenv 'theme' or 'dark'
M.theme = 'tokyonight'

return M
