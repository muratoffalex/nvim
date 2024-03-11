local config = require('config')

if config.current_theme == 'light' then
  vim.cmd.colorscheme 'tokyonight-day'
else
  vim.cmd.colorscheme 'tokyonight-storm'
end
