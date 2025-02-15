return {
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
    file_types = { 'markdown', 'Avante', 'copilot-chat' },
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
