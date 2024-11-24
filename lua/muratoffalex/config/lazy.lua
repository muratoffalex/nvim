local plugins = {
  { import = 'muratoffalex.plugins' },
  { import = 'muratoffalex.plugins.lang' },
  { import = 'muratoffalex.plugins.themes' },
}

local options = {
  checker = {
    enabled = false,
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    git = {
      timeout = 300,
    },
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        -- netrw and netrwPlugin need for downloading spell files
        -- disable when fixed https://github.com/stevearc/oil.nvim/issues/483
        -- 'netrw',
        -- 'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        -- "matchit",
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        -- "tutor",
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
}

-- Lazy init
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Lazy plugins
require('lazy').setup(plugins, options)
