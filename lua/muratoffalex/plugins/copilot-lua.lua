return {
  -- TODO: return original when this PR is merged
  -- https://github.com/zbirenbaum/copilot.lua/pull/336
  -- 'zbirenbaum/copilot.lua',
  'traysh/copilot.lua',
  branch = 'fix_issue_330',
  cmd = 'Copilot',
  event = 'InsertEnter',
  keys = {
    { '<leader>cs', '<cmd>Copilot suggestion<cr>', desc = 'Copilot suggestion' },
    { '<leader>ct', '<cmd>Copilot toggle<cr>', desc = 'Copilot toggle' },
  },
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enaled = true,
      auto_trigger = true,
      keymap = {
        accept = '<M-g>',
        accept_line = '<M-l>',
        accept_word = '<M-w>',
        next = '<M-.>',
        prev = '<M-,>',
        dismiss = '<M-x>',
      },
    },
  },
  config = function(_, opts)
    vim.g.copilot_proxy = require('muratoffalex.config').proxy
    require('copilot').setup(opts)

    vim.keymap.set('i', '<M-е>', require("copilot.suggestion").accept)
  end,
}
