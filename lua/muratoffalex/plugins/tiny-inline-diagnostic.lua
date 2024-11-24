return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  opts = {
    options = {
      multilines = true,
    },
  },
  config = function(_, opts)
    require('tiny-inline-diagnostic').setup(opts)

    vim.keymap.set('n', '<leader>tD', function()
      require('tiny-inline-diagnostic').toggle()
    end, { silent = true, desc = 'Toggle LSP Diagnostics' })

    -- TODO: just change highlight colors instead
    local function update_colors()
      local isLight = vim.o.background == 'light'
      local style = isLight and 'day' or 'moon'
      local blend = isLight and 0.35 or 0.25
      local colors = require('tokyonight.colors').setup { style = style }
      require('tiny-inline-diagnostic').change({ factor = blend }, {
        mixing_color = colors.bg,
      })
    end

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = update_colors,
    })

    update_colors()
  end,
}
