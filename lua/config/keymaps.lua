-- example fast map function
-- local function map(m, k, v)
--   vim.keymap.set(m, k, v, { noremap = true, silent = true })
-- end

local map = vim.keymap

map.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map.set('n', '<leader>l', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- NOTE: set in trouble
-- map.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

map.set('n', '<leader>fm', '<cmd>Format<cr>', { desc = 'Format file' })

map.set('n', '<Esc>', '<cmd> noh <CR>', { desc = 'Clear highlights' })
map.set('n', '<C-s>', '<cmd> w <CR>', { desc = 'Save file' })
map.set('n', '<C-c>', '<cmd> %y+ <CR>', { desc = 'Copy whole file' })

map.set('n', ';', 'enter command mode', { nowait = true })
map.set('n', '>', '>gv', { desc = 'Indent' })

map.set('n', '<leader>x', '<cmd>bd<cr>', { desc = 'Close current buffer' })
