return {
  'LintaoAmons/scratch.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>sn', '<cmd>Scratch<cr>', desc = 'Scratch new with name' },
    { '<leader>sN', '<cmd>ScratchWithName<cr>', desc = 'Scratch new' },
    { '<leader>so', '<cmd>ScratchOpen<cr>', desc = 'Scratch open' },
  },
  opts = {
    file_picker = 'snacks',
    filetypes = { 'go', 'php', 'lua', 'js', 'sh', 'ts' },
    filetype_details = {
      go = {
        requireDir = true,
        filename = 'main.go',
        content = { 'package main', '', 'func main() {', '  ', '}' },
        cursor = {
          location = { 4, 2 },
          insert_mode = true,
        },
      },
    },
  },
}
