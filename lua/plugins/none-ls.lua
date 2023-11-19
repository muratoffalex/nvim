return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local b = null_ls.builtins

    null_ls.setup {
      sources = {
        -- Lua
        b.formatting.stylua,

        -- Go
        b.formatting.gofmt,
        b.diagnostics.golangci_lint,
        -- b.diagnostics.revive,
        -- b.diagnostics.staticcheck,

        -- JS/TS/JSX/Vue
        b.code_actions.eslint,
        b.diagnostics.eslint,
        b.formatting.eslint,

        -- Typescript and Markdown
        b.formatting.prettierd,

        -- Markdown
        b.diagnostics.markdownlint,

        -- PHP
        b.formatting.phpcsfixer,
        b.diagnostics.phpcs,

        -- Other
        -- b.code_actions.gitsigns,
        -- b.diagnostics.psalm,
        --[[ -- run with project specific psalm
        b.diagnostics.psalm.with { command = './vendor/bin/psalm' },
        ]]
      },
    }
  end,
}
