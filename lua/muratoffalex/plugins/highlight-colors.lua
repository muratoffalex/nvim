-- differences from nvchad colorizer:
-- faster and simpler
-- supports tailwind colors, rgb, hsl etc.
-- supports rendering in background, foreground and virtual text
return {
  'brenoprata10/nvim-highlight-colors',
  event = 'VeryLazy',
  config = function()
    require('nvim-highlight-colors').setup {
      render = 'background',
      virtual_symbol = '⏺︎',
      enable_tailwind = true,
    }
  end,
}
