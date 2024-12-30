return {
  'b0o/incline.nvim',
  enabled = true,
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local devicons = require 'nvim-web-devicons'
    require('incline').setup {
      hide = {
        cursorline = true,
      },
      window = {
        padding = 1,
        margin = {
          horizontal = 0,
          vertical = 0,
        },
      },
      highlight = {
        groups = {
          -- block bg is transparent
          InclineNormal = {
            guibg = 'none',
          },
          InclineNormalNC = {
            guibg = 'none'
          },
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end

        local buf_modified = vim.api.nvim_get_option_value('modified', { buf = props.buf })
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        if buf_modified then
          ft_icon = '●'
          ft_color = '#ff0000'
        end

        return {
          { require('muratoffalex.utils.git').status(props.buf) },
          { (ft_icon or '') .. ' ', guifg = ft_color },
          { filename, gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
        }
      end,
    }
  end,
}
