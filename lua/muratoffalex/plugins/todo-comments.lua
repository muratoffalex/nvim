return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble' },
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  config = true,
  keys = {
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next todo comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Previous todo comment',
    },
    { '<leader>tt', '<cmd>TodoTrouble<cr>', desc = 'Todo (Trouble)' },
    { '<leader>tT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
    {
      '<leader>st',
      function()
        require('todo-comments.fzf').todo()
      end,
      desc = 'Todo',
    },
    {
      '<leader>sT',
      function()
        require('todo-comments.fzf').todo { keywords = { 'TODO', 'FIX', 'FIXME' } }
      end,
      desc = 'Todo/Fix/Fixme',
    },
  },
}
