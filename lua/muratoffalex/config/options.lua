-- speed up startup
vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = vim.api.nvim_replace_termcodes('<BS>', false, false, true)
vim.g.startup_message = false

local o = vim.opt

local config = require 'muratoffalex.config'

-- Spellchecking
-- mb use cspell instead?
o.spelllang = 'en,ru'
o.spelloptions = 'camel'
o.spell = true

o.background = config.background
o.swapfile = false
o.diffopt = 'filler,internal,closeoff,algorithm:histogram,linematch:60,context:5,indent-heuristic'

-- Sessions
o.sessionoptions = 'buffers,curdir,folds,tabpages'

-- Disable startup message
vim.o.shortmess = vim.o.shortmess .. 'I'

o.cursorline = true
-- NOTE: now in plugins/smartcolumn.lua
o.colorcolumn = '80,120'

-- Set highlight on search
o.hlsearch = true

-- Make line numbers default
o.number = true
o.scrolloff = 5

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
o.updatetime = 200 -- faster completion

-- Split options
o.splitright = true
o.splitbelow = true

-- Set completeopt to have a better completion experience
o.completeopt = 'menuone,noselect'

o.wrap = false -- display long lines with wrap

o.list = true
o.listchars = { tab = '>-', trail = '·' }

-- Default indent size
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
o.smartindent = true
o.autoindent = true

o.termguicolors = true
o.smoothscroll = true
