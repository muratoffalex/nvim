return {
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
    win_options = {
      conceallevel = { default = 0, rendered = 3 },
    },
    completions = { lsp = { enabled = true } },
    file_types = { 'markdown', 'Avante', 'copilot-chat', 'codecompanion' },
    checkbox = {
      checked = {
        highlight = 'Comment',
        scope_highlight = 'Comment',
      },
      custom = {
        -- NOTE: for obsidian.nvim
        failed = {
          raw = '[~]',
          rendered = '󰅙 ', -- nf-md-close_circle
          scope_highlight = 'Comment',
          highlight = 'Error',
        },
        in_progress = {
          raw = '[>]',
          rendered = '󰬪 ', -- nf-md-chevron_right_circle
          highlight = 'WinBarDiffAdded',
        },
        in_question = {
          raw = '[?]',
          rendered = '󰋗 ', -- nf-md-help_circle
          highlight = 'function',
          scope_highlight = 'function',
        },
        important = {
          raw = '[!]',
          rendered = '󰀨 ', -- nf-md-alert_circle
          highlight = 'WarningMsg',
          scope_highlight = 'WarningMsg',
        },
      },
    },
  },
}
