local absolute_vaults_directory = '/obsidian'
local vaults_directory = '~' .. absolute_vaults_directory

return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = {
    'ObsidianNew',
    'ObsidianOpen',
    'ObsidianQuickSwitch',
    'ObsidianFollowLink',
    'ObsidianBacklinks',
    'ObsidianTags',
    'ObsidianToday',
    'ObsidianYersterday',
    'ObsidianTomorrow',
    'ObsidianDailies',
    'ObsidianTemplate',
    'ObsidianSearch',
    'ObsidianLink',
    'ObsidianLinkNew',
    'ObsidianLinks',
    'ObsidianExtractNote',
    'ObsidianWorkspace',
    'ObsidianPasteImg',
    'ObsidianRename',
    'ObsidianToggleCheckbox',
  },
  keys = {
    { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'New note', noremap = true },
    { '<leader>oo', ':ObsidianOpen ', desc = 'Open note', noremap = true },
    { '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick switch', noremap = true },
    { '<leader>of', '<cmd>ObsidianFollowLink<cr>', desc = 'Follow link', noremap = true },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Backlinks', noremap = true },
    { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'Tags', noremap = true },
    { '<leader>odt', '<cmd>ObsidianToday<cr>', desc = 'Today', noremap = true },
    { '<leader>ody', '<cmd>ObsidianYersterday<cr>', desc = 'Yesterday', noremap = true },
    { '<leader>odT', '<cmd>ObsidianTomorrow<cr>', desc = 'Tomorrow', noremap = true },
    { '<leader>odd', '<cmd>ObsidianDailies<cr>', desc = 'Dailies', noremap = true },
    { '<leader>oT', '<cmd>ObsidianTemplate<cr>', desc = 'Template', noremap = true },
    { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Search', noremap = true },
    { '<leader>oL', '<cmd>ObsidianLink<cr>', desc = 'Link', noremap = true },
    { '<leader>oln', '<cmd>ObsidianLinkNew<cr>', desc = 'Link new', noremap = true },
    { '<leader>ols', '<cmd>ObsidianLinks<cr>', desc = 'Links', noremap = true },
    { '<leader>oe', ':ObsidianExtractNote ', desc = 'Extract note', noremap = true, mode = 'x' },
    { '<leader>ow', '<cmd>ObsidianWorkspace<cr>', desc = 'Workspace', noremap = true },
    { '<leader>op', '<cmd>ObsidianPasteImg<cr>', desc = 'Paste image', noremap = true },
    { '<leader>or', '<cmd>ObsidianRename<cr>', desc = 'Rename', noremap = true },
  },
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. absolute_vaults_directory .. '/**/**.md',
    'BufNewFile ' .. vim.fn.expand '~' .. absolute_vaults_directory .. '/**/**.md',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
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
