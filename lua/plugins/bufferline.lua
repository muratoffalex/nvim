return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>',            desc = 'Toggle pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>',          desc = 'Delete other buffers' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>',           desc = 'Delete buffers to the right' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>',            desc = 'Delete buffers to the left' },
    { '<S-Tab>',    '<cmd>BufferLineCyclePrev<cr>',            desc = 'Prev buffer' },
    { '<Tab>',      '<cmd>BufferLineCycleNext<cr>',            desc = 'Next buffer' },
    { '[b',         '<cmd>BufferLineCyclePrev<cr>',            desc = 'Prev buffer' },
    { ']b',         '<cmd>BufferLineCycleNext<cr>',            desc = 'Next buffer' },
  },
  config = function()
    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.no_italic,
        separator_style = { '', '' },
        -- -- stylua: ignore
        -- close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- -- stylua: ignore
        -- right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = {
            Error = ' ',
            Warn = ' ',
            Hint = ' ',
            Info = ' ',
          }
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') ..
          (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'dbui',
            text = 'DB UI',
            highlight = 'Directory',
          },
        },
      },
    }
    -- for from 1 to 9
    for i = 1, 9 do
      vim.keymap.set(
        'n',
        string.format('<A-%s>', i),
        string.format('<cmd>BufferLineGoToBuffer %s<CR>', i),
        { noremap = true, silent = true }
      )
    end
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd('BufAdd', {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
