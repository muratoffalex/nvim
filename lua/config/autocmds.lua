local utils = require 'utils'

-- AUTOCOMMANDS
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup('General Settings', { clear = true })
local highlight_group = augroup('YankHighlight', { clear = true })
local templates_group = augroup('Templates', { clear = true })

autocmd({ 'BufNewFile', 'BufReadPost' }, {
   pattern = '*.php',
   callback = function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local content = table.concat(lines, '\n')

      if not content:find '<%?php' and not content:find '<%?' then
         utils.template_builders.php.build_by_content()
      end
   end,
   group = templates_group,
   desc = 'Insert base PHP template',
})

autocmd({ 'BufRead', 'BufNewFile' }, {
   pattern = { '*.podspec', 'Podfile' },
   command = 'set filetype=ruby',
})

autocmd('BufReadPost', {
   pattern = '*',
   command = 'silent! normal! g`"zv',
   group = general,
   desc = 'Open file at the last position it was edited earlier',
})

autocmd('TextYankPost', {
   callback = function()
      vim.highlight.on_yank()
   end,
   group = highlight_group,
   pattern = '*',
   desc = 'Highlight on yank',
})

autocmd('FileType', {
   pattern = { 'go', 'php', 'sh' },
   callback = function()
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
   end,
   group = general,
   desc = 'Filetype Settings',
})

autocmd('FileType', {
   pattern = 'html',
   callback = function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
   end,
   group = general,
   desc = 'Html Filetype Settings',
})

-- NOTE: 'BufWinLeave' - this event fires after every change... Why?
autocmd({ 'FocusLost', 'BufLeave', 'InsertLeave' }, {
   callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local modified = vim.api.nvim_buf_get_option(buf, 'modified')
      if vim.bo.filetype ~= '' and vim.bo.buftype == '' and modified then
         vim.cmd 'silent! w'
      end
   end,
   group = general,
   desc = 'Auto Save',
})

autocmd('FocusGained', {
   callback = function()
      vim.cmd 'checktime'
   end,
   group = general,
   desc = 'Update file when there are changes',
})

autocmd('VimResized', {
   callback = function()
      vim.cmd 'wincmd ='
   end,
   group = general,
   desc = 'Equalize Splits',
})

-- mason-tool-installer
autocmd('User', {
   pattern = 'MasonToolsUpdateCompleted',
   callback = function(e)
      vim.schedule(function()
         -- os.execute('~/.local/share/nvim/mason/bin/phpcs --config-set default_standard PSR12')
         -- check if the table is empty before printing it
         if next(e.data) == nil then
            return
         end
         print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
      end)
   end,
   group = general,
   desc = 'Mason Tools update completed message',
})

