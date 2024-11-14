return {
   'nvimtools/none-ls.nvim',
   event = 'VeryLazy',
   dependencies = {
      {
         'WhoIsSethDaniel/mason-tool-installer.nvim',
         dependencies = {
            'williamboman/mason.nvim',
         },
      },
   },
   config = function()
      local null_ls = require 'null-ls'
      local b = null_ls.builtins

      local mason_tool_installer = require 'mason-tool-installer'
      mason_tool_installer.setup {
         ensure_installed = {
            'stylua',        -- lua formatter
            'phpcbf',
            'phpcs',         -- php linter
            'prettier',      -- general formatter (markdown, json, etc)
            'prettierd',     -- prettier daemon
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

      -- TODO: format file on save 
      -- https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save
   end,
}
