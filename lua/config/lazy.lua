local plugins = {
  { import = 'plugins' },
  { import = 'plugins.lsp' },
  { import = 'plugins.themes' },
}

local options = {
  performance = {
    cache = {
      enabled = false,
    },
    rtp = {
      disabled_plugins = {
          "netrw",
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
