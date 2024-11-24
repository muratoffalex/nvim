vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

vim.opt_local.textwidth = 80
vim.opt_local.formatoptions = vim.opt_local.formatoptions
    + 'r'   -- Auto-insert comment leader after <Enter>
    + 'q'   -- Allow formatting of comments with gq

vim.opt_local.commentstring = '# %s'
