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
  kinds = {
    Array = ' ',
    Boolean = '󰨙 ',
    Class = ' ',
    Codeium = '󰘦 ',
    Color = ' ',
    Control = ' ',
    Collapsed = ' ',
    Constant = '󰏿 ',
    Constructor = ' ',
    Copilot = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = ' ',
    Folder = ' ',
    Function = '󰊕 ',
    Interface = ' ',
    Key = ' ',
    Keyword = ' ',
    Method = '󰊕 ',
    Module = ' ',
    Namespace = '󰦮 ',
    Null = ' ',
    Number = '󰎠 ',
    Object = ' ',
    Operator = ' ',
    Package = ' ',
    Property = ' ',
    Reference = ' ',
    Snippet = '󱄽 ',
    String = ' ',
    Struct = '󰆼 ',
    Supermaven = ' ',
    TabNine = '󰏚 ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = '󰀫 ',
  },
}

-- change to local cache because env is not stable
M.background = cache.read_value('background', 'dark')
M.theme = (cache.read_value('theme', 'kanagawa')):match '^([^-]+)'
M.current_os = vim.env.current_os or 'unknown'

M.picker = 'snacks'

return M
