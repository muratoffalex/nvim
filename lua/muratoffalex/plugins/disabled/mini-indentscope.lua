return {
   'echasnovski/mini.indentscope',
   enabled = false,
   version = false,
   config = function()
      require('mini.indentscope').setup {
         symbol = '│',
         options = { try_as_border = true },
      }
   end,
}
