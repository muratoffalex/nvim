local absolute_vaults_directory = '/obsidian'
local vaults_directory = '~' .. absolute_vaults_directory

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = 'Obsidian',
  keys = {
    { '<leader>on', '<cmd>Obsidian new<cr>', desc = 'New note', noremap = true },
    { '<leader>oo', ':Obsidian open ', desc = 'Open note', noremap = true },
    { '<leader>oq', '<cmd>Obsidian quick_switch<cr>', desc = 'Quick switch', noremap = true },
    { '<leader>of', '<cmd>Obsidian follow_link<cr>', desc = 'Follow link', noremap = true },
    { '<leader>ob', '<cmd>Obsidian backlinks<cr>', desc = 'Backlinks', noremap = true },
    { '<leader>ot', '<cmd>Obsidian tags<cr>', desc = 'Tags', noremap = true },
    { '<leader>odt', '<cmd>Obsidian today<cr>', desc = 'Today', noremap = true },
    { '<leader>ody', '<cmd>Obsidian yersterday<cr>', desc = 'Yesterday', noremap = true },
    { '<leader>odT', '<cmd>Obsidian tomorrow<cr>', desc = 'Tomorrow', noremap = true },
    { '<leader>odd', '<cmd>Obsidian dailies<cr>', desc = 'Dailies', noremap = true },
    { '<leader>oT', '<cmd>Obsidian template<cr>', desc = 'Template', noremap = true },
    { '<leader>os', '<cmd>Obsidian search<cr>', desc = 'Search', noremap = true },
    { '<leader>oL', '<cmd>Obsidian link<cr>', desc = 'Link', noremap = true },
    { '<leader>oln', '<cmd>Obsidian link_new<cr>', desc = 'Link new', noremap = true },
    { '<leader>ols', '<cmd>Obsidian links<cr>', desc = 'Links', noremap = true },
    { '<leader>oe', ':Obsidian extract_note ', desc = 'Extract note', noremap = true, mode = 'x' },
    { '<leader>ow', '<cmd>Obsidian workspace<cr>', desc = 'Workspace', noremap = true },
    { '<leader>op', '<cmd>Obsidian paste_img<cr>', desc = 'Paste image', noremap = true },
    { '<leader>or', '<cmd>Obsidian rename<cr>', desc = 'Rename', noremap = true },
  },
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. absolute_vaults_directory .. '/**/**.md',
    'BufNewFile ' .. vim.fn.expand '~' .. absolute_vaults_directory .. '/**/**.md',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    legacy_commands = false,
    completion = {
      nvim_cmp = false,
      blink = true,
    },
    ui = {
      enable = false,
    },
    workspaces = {
      {
        name = 'omain',
        path = vaults_directory .. '/omain',
      },
      {
        name = 'owork',
        path = vaults_directory .. '/owork',
      },
    },
    daily_notes = {
      folder = 'dailies',
    },
    -- Optional, for templates (see below).
    templates = {
      subdir = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
  },
}
