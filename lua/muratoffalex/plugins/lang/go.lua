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
      dap_debug_gui = {
        layouts = {
          {
            elements = {
              { id = 'stacks', size = 0.25 },
              { id = 'scopes', size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            position = 'right',
            size = 40,
          },
          {
            elements = {
              { id = 'repl', size = 1 },
            },
            position = 'bottom',
            size = 10,
          },
        },
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
      keymap('lgl', '<cmd>GoLint<cr>', 'Run linter')
      keymap('lga', '<cmd>GoAlt!<cr>', 'Open test/file')
      keymap('lgA', '<cmd>GoAltV!<cr>', 'Open test/file in vsplit')
      keymap('lgta', '<cmd>GoTest<cr>', 'Run all tests')
      keymap('lgtf', '<cmd>GoTestFile<cr>', 'Run file tests')
      keymap('lgtp', '<cmd>GoTestPkg<cr>', 'Run package tests')
      keymap('lgtF', '<cmd>GoTestFunc<cr>', 'Run func tests')
      keymap('lgT', '<cmd>GoBreakToggle<cr>', 'Toggle breakpoint')

      local format_sync_grp = vim.api.nvim_create_augroup('goimports', {})
      vim.api.nvim_create_autocmd({ 'BufWritePre', 'BufWriteCmd' }, {
        pattern = '*.go',
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })

      require('which-key').add {
        { 'lg', group = 'Golang' },
      }
    end,
  },
}
