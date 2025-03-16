local config = require 'muratoffalex.config'

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'echasnovski/mini.icons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = true,
  cmd = { 'Neotree' },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Neotree toggle' },
  },
  opts = function(_, opts)
    -- Snacks rename
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require 'neo-tree.events'
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    return {
      window = {
        mappings = {
          ['P'] = {
            'toggle_preview',
            config = {
              use_float = false,
            },
          },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- default unstaged icon not showing
            unstaged = config.icons.git.unstaged,
          },
        },
      },
    }
  end,
}
