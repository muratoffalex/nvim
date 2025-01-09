return {
  'smjonas/inc-rename.nvim',
  config = function()
    require('inc_rename').setup({})

    vim.keymap.set('n', '<leader>cr', function()
      return ':IncRename '
    end, { expr = true, desc = 'Rename' })
    vim.keymap.set('n', '<leader>cR', function()
      return ':IncRename ' .. vim.fn.expand '<cword>'
    end, { expr = true, desc = 'Rename (prefill word)' })
  end,
}
