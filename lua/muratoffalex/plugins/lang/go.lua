return {
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'go', 'gomod' },
    opts = {
      lsp_inlay_hints = {
        enable = false,
      },
    },
    config = function(_, opts)
      require('go').setup(opts)

      local function keymap(key, cmd, desc)
        local prefix = '[Go]'
        vim.keymap.set('n', '' .. key, cmd, { desc = prefix .. ' ' .. desc })
      end

      keymap('lgr', '<cmd>GoRun<cr>', 'Run')
      keymap('lgd', '<cmd>GoDebug<cr>', 'Debug')
      keymap('lga', '<cmd>GoAlt!<cr>', 'Open test/file')
      keymap('lgA', '<cmd>GoAltV!<cr>', 'Open test/file in vsplit')
      keymap('lgt', '<cmd>GoTest<cr>', 'Run tests')
      keymap('lgT', ':GoTest', 'Run tests with args')

      local format_sync_grp = vim.api.nvim_create_augroup('goimports', {})
      vim.api.nvim_create_autocmd({'BufWritePre','BufWriteCmd'}, {
        pattern = '*.go',
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })

      require('which-key').add({
        { 'lg', group = 'Golang' },
      })
    end,
  },
}
