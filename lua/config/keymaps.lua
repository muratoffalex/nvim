local map = vim.keymap

map.set({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- remap for dealing with word wrap
map.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Same with arrows for split keyboard with layout miryoku
map.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map.set('n', '<leader>l', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map.set('n', '<leader>fm', '<cmd>Format<cr>', { desc = 'Format file' })

-- Common keymaps
map.set('n', '<Esc>', '<cmd> noh <CR>', { desc = 'Clear highlights' })
map.set('n', '<C-s>', '<cmd> w <CR>', { desc = 'Save file' })
map.set('n', '<C-c>', '<cmd> %y+ <CR>', { desc = 'Copy whole file' })
map.set('n', '<leader>x', '<cmd>bd<cr>', { desc = 'Close current buffer' })
map.set('n', '<A-n>', '<cmd>set relativenumber!<cr>', { desc = 'Toggle relative number' })

-- Move lines
map.set('n', '<S-Up>', '<cmd>m-2<cr>', { desc = 'Move line up' })
map.set('n', '<S-Down>', '<cmd>m+<cr>', { desc = 'Move line down' })
map.set('i', '<S-Up>', '<Esc><cmd>m .-2<CR>==gi', { desc = 'Move line up' })
map.set('i', '<S-Down>', '<Esc><cmd>m .+1<CR>==gi', { desc = 'Move line down' })
map.set('v', '<S-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move line or block up' })
map.set('v', '<S-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move line or block down' })

-- Terminal
map.set('t', '<C-x>', '<C-\\><C-n>', { desc = 'Switch to normal mode' })

-- Split windows
map.set('n', 'ss', '<cmd>split<cr>', { desc = 'Split window horizontally', noremap = true })
map.set('n', 'sv', '<cmd>vsplit<cr>', { desc = 'Split window vertically', noremap = true })
map.set('n', 'sq', '<C-w>q', { desc = 'Close window' })
map.set('n', 'sh', '<C-w>h', { desc = 'Go to left window' })
map.set('n', 'sj', '<C-w>j', { desc = 'Go to bottom window' })
map.set('n', 'sk', '<C-w>k', { desc = 'Go to top window' })
map.set('n', 'sl', '<C-w>l', { desc = 'Go to right window' })

-- TODO: Move workspace keymaps to <leader>dw ?
