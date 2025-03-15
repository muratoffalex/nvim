local cache = require 'muratoffalex.utils.cache'

local M = {}

M.icons = {
  git = {
    added = ' ',
    changed = ' ',
    copied = ' ',
    deleted = ' ',
    ignored = ' ',
    renamed = ' ',
    staged = ' ',
    unmerged = ' ',
    unstaged = ' ',
    untracked = ' ',
  },
  diagnostics = {
    error = ' ',
    warn = ' ',
    hint = ' ',
    info = ' ',
  },
}

-- change to local cache because env is not stable
M.background = cache.read_value('background', 'light')
M.theme = (cache.read_value('theme', 'kanagawa')):match("^([^-]+)")
M.current_os = vim.env.current_os or 'unknown'

M.picker = 'fzflua'

return M
