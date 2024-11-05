return {
   'rachartier/tiny-inline-diagnostic.nvim',
   event = 'VeryLazy',
   -- disable because buggy
   enabled = false,
   config = function()
      require('tiny-inline-diagnostic').setup()

      vim.keymap.set('n', '<leader>tD', function()
         require('tiny-inline-diagnostic').toggle()
      end, { silent = true, desc = 'Toggle LSP Diagnostics' })

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
