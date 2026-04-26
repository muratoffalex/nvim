-- not needed
return {
  'kosayoda/nvim-lightbulb',
  event = 'LspAttach',
  config = function()
    require('nvim-lightbulb').setup {
      autocmd = { enabled = true },
      sign = { enabled = false },
      float = { enabled = false },
      virtual_text = { enabled = true },
      status_text = { enabled = false },
      number = {
        enabled = false,
        -- Highlight group to highlight the number column if there is a lightbulb.
        hl = 'LightBulbNumber',
      },
    }
  end,
}
