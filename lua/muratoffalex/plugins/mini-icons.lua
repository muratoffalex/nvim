-- ref: https://github.com/LazyVim/LazyVim/blob/b574f01af7ab5eaccdef16db60c1fdd94e8ff12d/lua/lazyvim/plugins/ui.lua#L244
return {
  'mini-nvim/mini.icons',
  lazy = true,
  opts = {
    file = {
      ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
      ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    },
    filetype = {
      dotenv = { glyph = '', hl = 'MiniIconsYellow' },
    },
  },
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}
