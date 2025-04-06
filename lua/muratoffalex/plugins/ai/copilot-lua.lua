return {
  'zbirenbaum/copilot.lua',
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
}
