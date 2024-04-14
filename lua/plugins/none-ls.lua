return {
   'nvimtools/none-ls.nvim',
   config = function()
      local null_ls = require 'null-ls'
      local b = null_ls.builtins

      null_ls.setup {
         sources = {
            -- Lua
            b.formatting.stylua,

            -- Swift
            b.diagnostics.swiftlint,
            b.formatting.swiftformat,

            -- Go
            b.formatting.gofmt,
            b.diagnostics.golangci_lint,

            -- JS/TS/JSX/Vue
            -- b.code_actions.eslint,
            -- b.diagnostics.eslint,
            -- b.formatting.eslint,

            -- Typescript and Markdown
            b.formatting.prettierd,

            -- Markdown
            b.diagnostics.markdownlint,

            -- PHP
            b.formatting.phpcsfixer,
            b.diagnostics.phpcs,
         },
      }
   end,
}
