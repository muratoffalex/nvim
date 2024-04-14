return {
   'zbirenbaum/copilot.lua',
   cmd = 'Copilot',
   enabled = true,
   event = 'InsertEnter',
   keys = {
      { '<leader>cs', '<cmd>Copilot suggestion<cr>', desc = 'Copilot suggestion' },
      { '<leader>cp', '<cmd>Copilot panel<cr>', desc = 'Copilot panel' },
      { '<leader>ct', '<cmd>Copilot toggle<cr>', desc = 'Copilot toggle' },
   },
   opts = {
      panel = {
         enabled = true,
         auto_refresh = true,
         keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
         },
         layout = {
            position = 'bottom', -- | top | left | right
            ratio = 0.4,
         },
      },
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
