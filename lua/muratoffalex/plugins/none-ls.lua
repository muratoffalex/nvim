return {
   'nvimtools/none-ls.nvim',
   dependencies = {
      {
         'WhoIsSethDaniel/mason-tool-installer.nvim',
         dependencies = {
            'williamboman/mason.nvim',
         }
      },
   },
   config = function()
      local null_ls = require 'null-ls'
      local b = null_ls.builtins

      local mason_tool_installer = require 'mason-tool-installer'
      mason_tool_installer.setup {
         ensure_installed = {
            'stylua',        -- lua formatter
            'eslint',        -- js/ts formatter/linter
            'phpcbf',
            'phpcs',         -- php linter
            'prettierd',     -- general formatter (markdown, json, etc)
            'markdownlint',  -- markdown linter
            'golangci-lint', -- go linter
         },
      }

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
            -- b.formatting.phpcsfixer,
            b.diagnostics.phpcs,
            b.formatting.phpcbf,

            b.formatting.xmllint,
         },
      }
   end,
}
