return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = true,
  cmd = { 'Neotree' },
  keys = {
    { '<C-e>', '<cmd>Neotree toggle<cr>', desc = 'Neotree toggle' },
    { '<leader>e', '<cmd>Neotree<cr>', desc = 'Neotree open' },
  },
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      }
    },
  },
}
