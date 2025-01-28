return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = function()
      return {
        library = {
          uv = 'luvit-meta/library',
          { path = 'snacks.nvim', words = { 'Snacks' } },
        },
      }
    end,
  },
  -- Manage libuv types with lazy. Plugin will never be loaded
  { 'Bilal2453/luvit-meta', lazy = true },
}
