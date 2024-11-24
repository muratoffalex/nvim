-- not needed
return {
  'kosayoda/nvim-lightbulb',
  event = 'LspAttach',
  config = function()
    require('nvim-lightbulb').setup {
      autocmd = { enabled = true },
      sign = { enabled = false },
      float = { enabled = false },
      virtual_text = { enabled = false },
      status_text = { enabled = false },
    }
  end,
}
