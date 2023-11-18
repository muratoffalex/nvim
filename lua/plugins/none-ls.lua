return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local b = null_ls.builtins

    null_ls.setup {
      sources = {
        -- b.code_actions.gitsigns,
        b.code_actions.eslint,
        b.formatting.stylua,
        b.diagnostics.eslint,
        b.formatting.eslint,
        b.completion.spell,
        b.formatting.prettierd,

        b.diagnostics.markdownlint,
        b.formatting.phpcsfixer,
        b.diagnostics.phpcs,
        -- b.diagnostics.psalm,
        -- b.diagnostics.psalm.with { command = './vendor/bin/psalm' },
      },
    }
  end,
}
