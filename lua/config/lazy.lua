local plugins = {
  { import = 'plugins' },
  { import = 'plugins.lsp' },
  { import = 'plugins.themes' },
}

local plugins_old = {
  require 'plugins.bulblight',
  require 'plugins.noice',
  require 'plugins.trouble',
  require 'plugins.mini-map',
  require 'plugins.maximizer',
  require 'plugins.code-actions',
  require 'plugins.bufferline',
  require 'plugins.dadbodui',
  require 'plugins.barbecue',
  require 'plugins.projectmgr',
  require 'plugins.wakatime',
  require 'plugins.git',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.ibl',
  require 'plugins.lualine',
  require 'plugins.lsp',
  require 'plugins.nvim-cmp',
  require 'plugins.neotree',
  require 'plugins.whichkey',
  require 'plugins.none-ls',
  require 'plugins.themes.tokyonight',
  require 'plugins.other',
}

local options = {
  performance = {
    cache = {
      enabled = false,
    },
    rtp = {
      disabled_plugins = {
          -- "netrw",
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
