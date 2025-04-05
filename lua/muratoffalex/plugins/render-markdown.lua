return {
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
    win_options = {
      conceallevel = { default = 0, rendered = 3 },
    },
    completions = { lsp = { enabled = true } },
    file_types = { 'markdown', 'Avante', 'copilot-chat', 'codecompanion' },
    checkbox = {
      -- unchecked = {
      --   icon = '○',
      -- },
      checked = {
        -- icon = '✓',
        highlight = 'Comment',
        scope_highlight = 'Comment',
      },
      custom = {
        -- NOTE: for obsidian.nvim
        failed = {
          raw = '[~]',
          rendered = '󰰱 ',
          -- rendered = '⊝',
          highlight = 'Error',
        },
        in_progress = {
          raw = '[>]',
          rendered = ' ',
          -- rendered = '◐',
          highlight = 'WinBarDiffChanged',
        },
        important = {
          raw = '[!]',
          rendered = ' ',
          -- rendered = '◉',
          highlight = 'Constant',
        },
      },
    },
  },
}
