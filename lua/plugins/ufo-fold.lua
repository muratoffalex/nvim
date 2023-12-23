return {
  'kevinhwang91/nvim-ufo',
  enabled = true,
  event = 'VeryLazy',
  init = function()
    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldmethod = 'indent'
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  end,
  opts = {
    provider_selector = function(_, _, _)
      return { 'treesitter', 'indent' }
    end,
  },
  dependencies = {
    'kevinhwang91/promise-async',
    --  {
    --    'luukvbaal/statuscol.nvim',
    --    config = function()
    --      local builtin = require 'statuscol.builtin'
    --      require('statuscol').setup {
    --        relculright = true,
    --        segments = {
    --          { text = { '%s' },                  click = 'v:lua.ScSa' },
    --          { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
    --          { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
    --        },
    --      }
    --    end,
    -- },
  },
}
