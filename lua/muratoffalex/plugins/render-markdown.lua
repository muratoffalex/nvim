return {
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
    file_types = { 'markdown', 'Avante', 'copilot-chat' },
    checkbox = {
      custom = {
        -- NOTE: for obsidian.nvim
        failed = {
          raw = '[~]',
          rendered = '󰰱 ',
          highlight = 'WinBarDiffRemoved',
        },
        in_progress = {
          raw = '[>]',
          rendered = ' ',
          highlight = 'WinBarDiffChanged',
        },
        important = {
          raw = '[!]',
          rendered = ' ',
          highlight = 'WinBarDiffAdded',
        },
      },
    },
  },
}
