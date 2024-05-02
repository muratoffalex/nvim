-- speed up startup
vim.loader.enable()

-- space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.startup_message = false

local o = vim.o

local config = require 'config'

o.background = config.background

-- Default indent size
o.shiftwidth = 2
o.tabstop = 2

o.shortmess = o.shortmess .. 'I'
-- for obsidian
o.conceallevel = 1

o.cursorline = true
-- NOTE: now in plugins/smartcolumn.lua
o.colorcolumn = '80,120'

-- Set highlight on search
o.hlsearch = true

-- Make line numbers default
o.number = true
o.scrolloff = 10

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
o.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 100 -- faster completion
o.timeoutlen = 300

-- Set completeopt to have a better completion experience
o.completeopt = 'menuone,noselect'

o.wrap = true -- display long lines with wrap

o.termguicolors = true
