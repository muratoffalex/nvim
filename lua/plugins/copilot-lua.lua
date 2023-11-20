return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  enabled = true,
  event = 'InsertEnter',
  opts = {
    suggestion = {
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
