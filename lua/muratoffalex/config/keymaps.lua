local map = vim.keymap

map.set({ 'n', 'v' }, '<space>', '<nop>', { silent = true })
map.set({ 'n', 'v' }, '<bs>', '<nop>', { silent = true })

-- remap for dealing with word wrap
map.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map.set('n', '<A-Up>', '1<C-y>', { desc = 'Vertical scroll top 20', noremap = true })
map.set('n', '<A-Down>', '1<C-e>', { desc = 'Vertical scroll down 20', noremap = true })
map.set('n', '<A-Left>', 'zh20', { desc = 'Horizontal scroll left 20', noremap = true })
map.set('n', '<A-Right>', 'zl20', { desc = 'Horizontal scroll right 20', noremap = true })

map.set('n', '<C-n>', '<C-i>', { desc = 'Jump next', noremap = true })

-- Diagnostic keymaps
map.set('n', '<leader>l', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map.set('n', '<leader>fm', '<cmd>Format<cr>', { desc = 'Format file' })
map.set('v', '<leader>fm', '<cmd>Format<cr>', { desc = 'Format selected lines' })

-- Language specific keymaps
map.set('n', 'ф', 'a')
map.set('n', 'д', 'i')
map.set('n', 'ж', 'o')
map.set('n', 'ш', 'u')

-- Common keymaps
map.set('n', '<Esc>', '<cmd>noh<CR>', { desc = 'Clear highlights' })
map.set('n', '<C-s>', '<cmd>silent w<CR>', { desc = 'Save file' })
map.set('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'Copy whole file' })
map.set('n', '<leader>x', '<cmd>bd<cr>', { desc = 'Close current buffer' })
map.set('n', '<leader>X', '<cmd>bd!<cr>', { desc = 'Close current buffer force' })
map.set('n', '<leader>nr', '<cmd>set relativenumber!<cr>', { desc = 'Toggle relative number' })
map.set('n', '<leader>nw', function()
  vim.o.wrap = not vim.o.wrap
end, { desc = 'Toggle lines wrap mode' })
-- htps://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
map.set('n', 'x', '"_x')
map.set('n', 'c', '"_c')
map.set('n', 'dd', function()
  if vim.fn.getline '.' == '' then
    return '"_dd'
  end
  return 'dd'
end, { expr = true, desc = 'Only yank text with dd from non-empty lines' })

-- Move lines
map.set('n', '<S-Up>', '<cmd>m-2<cr>', { desc = 'Move line up' })
map.set('n', '<S-Down>', '<cmd>m+<cr>', { desc = 'Move line down' })
map.set('i', '<S-Up>', '<Esc><cmd>m .-2<CR>==gi', { desc = 'Move line up' })
map.set('i', '<S-Down>', '<Esc><cmd>m .+1<CR>==gi', { desc = 'Move line down' })
map.set('v', '<S-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move line or block up', silent = true })
map.set('v', '<S-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move line or block down', silent = true })

-- Terminal
map.set('t', '<C-x>', '<C-\\><C-n>', { desc = 'Switch to normal mode' })

-- Tabs
map.set('n', '<leader>tN', '<cmd>tabnew<cr>', { desc = 'New tab' })
map.set('n', '<leader>tC', '<cmd>tabclose<cr>', { desc = 'Close tab' })
map.set('n', '<leader>to', '<cmd>tabonly<cr>', { desc = 'Close other tabs' })
map.set('n', '<leader>tn', '<cmd>tabnext<cr>', { desc = 'Next tab' })
map.set('n', '<leader>tp', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })

-- Split windows
-- TODO: mb remap to <leader>s
map.set('n', 'ss', '<cmd>split<cr>', { desc = 'Split window horizontally', noremap = true })
map.set('n', 'sv', '<cmd>vsplit<cr>', { desc = 'Split window vertically', noremap = true })
map.set('n', 'sq', '<C-w>q', { desc = 'Close window' })
-- NOTE: Set to neio because I'm on colemak on split keyboard (arrows in layer in this position)
map.set('n', 'sn', '<C-w>h', { desc = 'Go to left window' })
map.set('n', 'se', '<C-w>j', { desc = 'Go to bottom window' })
map.set('n', 'si', '<C-w>k', { desc = 'Go to top window' })
map.set('n', 'so', '<C-w>l', { desc = 'Go to right window' })
-- move split windows
map.set('n', 'sN', '<C-w>H', { desc = 'Move window to left' })
map.set('n', 'sE', '<C-w>J', { desc = 'Move window to bottom' })
map.set('n', 'sI', '<C-w>K', { desc = 'Move window to top' })
map.set('n', 'sO', '<C-w>L', { desc = 'Move window to right' })
map.set('n', 'sr', '<C-w>r', { desc = 'Swap two windows' })
-- resize split windows
map.set('n', 's>', '<cmd>5winc ><cr>', { desc = 'Increase window width 5' })
map.set('n', 's<', '<cmd>5winc <<cr>', { desc = 'Decrease window width 5' })
map.set('n', 's+', '<cmd>resize +5<cr>', { desc = 'Increase window height 5' })
map.set('n', 's-', '<cmd>resize -5<cr>', { desc = 'Decrease window height 5' })

-- Misc
-- Toggle list
map.set('n', '<leader>nl', '<cmd>set list!<cr>', { desc = 'Toggle list' })
-- https://www.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/
map.set("n", "ycc", '"yy" . v:count1 . "gcc\']p"', { remap = true, expr = true })
map.set("x", "/", "<Esc>/\\%V") -- search within visual selection
map.set("n", "J", "mzJ`z:delmarks z<cr>")

-- Advanced keymaps

vim.keymap.set('v', '<leader>lml', function()
  vim.cmd "let @a = getreg('+')"
  vim.cmd 'normal d'
  vim.cmd 'startinsert'
  vim.api.nvim_put({ '[]() ' }, 'c', true, true)
  vim.cmd 'normal F[pf('
  vim.cmd "call setreg('+', @a)"
  vim.cmd 'normal p'
  vim.cmd 'stopinsert'
end, { desc = '[Markdown] Convert to link' })
