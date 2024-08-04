return {
   {
      'echasnovski/mini.files',
      version = '*',
   },
   {
      'ibhagwan/fzf-lua',
      -- optional for icon support
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
         -- calling `setup` is optional for customization
         -- TODO: git_icons = true
         require('fzf-lua').setup {}
      end,
   },
}
