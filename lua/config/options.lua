-- speed up startup
vim.loader.enable()

-- space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.startup_message = false

local o = vim.o
local wo = vim.wo
local opt = vim.opt
local config = require 'config'

vim.o.background = config.background

-- Default indent size
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.o.shortmess = vim.o.shortmess .. 'I'

opt.cursorline = true
-- NOTE: now in plugins/smartcolumn.lua
opt.colorcolumn = '80,120'

-- Set highlight on search
o.hlsearch = true

-- Make line numbers default
wo.number = true

-- Enable mouse mode
o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
o.clipboard = 'unnamedplus'

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
wo.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 100 -- faster completion
o.timeoutlen = 300

-- Set completeopt to have a better completion experience
o.completeopt = 'menuone,noselect'

o.wrap = true -- display long lines with wrap

o.termguicolors = true
