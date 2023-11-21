-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- mason-tool-installer
vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonToolsUpdateCompleted',
  callback = function(e)
    vim.schedule(function()
      -- os.execute('~/.local/share/nvim/mason/bin/phpcs --config-set default_standard PSR12')
      print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
    end)
  end,
})
