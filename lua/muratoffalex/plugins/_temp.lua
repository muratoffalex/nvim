return {
  {
    'lfilho/note2cal.nvim',
    config = function()
      require('note2cal').setup {
        debug = false, -- if true, prints a debug message an return early (won't schedule events)
        calendar_name = 'Рабочий', -- the name of the calendar as it appear on Calendar.app
        highlights = {
          at_symbol = 'WarningMsg', -- the highlight group for the "@" symbol
          at_text = 'Number', -- the highlight group for the date-time part
        },
        keymaps = {
          normal = '<Leader>se', -- mnemonic: Schedule Event
          visual = '<Leader>se', -- mnemonic: Schedule Event
        },
      }
    end,
    ft = 'markdown',
  },
  {
    'xzbdmw/colorful-menu.nvim',
    opts = {},
  },
  {
    -- jujutsu squashing
    'julienvincent/hunk.nvim',
    cmd = { 'DiffEditor' },
    opts = {},
  },
  {
    'barrett-ruth/live-server.nvim',
    build = 'npm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true,
  },
}
