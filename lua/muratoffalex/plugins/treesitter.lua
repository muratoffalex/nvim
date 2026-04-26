return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
    },
    'windwp/nvim-ts-autotag',
    'gbprod/php-enhanced-treesitter.nvim',
  },
  event = { 'BufReadPre', 'BufWritePost', 'BufNewFile' },
  build = ':TSUpdate',
  branch = 'main',
  init = function()
    local ensureInstalled = {
      'go',
      'lua',
      'python',
      'rust',
      'vue',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'bash',
      'php',
      'html',
      'css',
      'markdown',
      'markdown_inline',
      'regex',
    }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim
      .iter(ensureInstalled)
      :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
      end)
      :totable()
    require('nvim-treesitter').install(parsersToInstall)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  config = function()
    -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
    vim.defer_fn(function()
      require('nvim-treesitter').setup {
        -- Autoinstall languages that are not installed. Defaults to false
        auto_install = true,
        modules = {},
        sync_install = false,
        ignore_install = {},

        highlight = {
          enable = true,
          -- chezmoi plugin
          disable = function()
            -- check if 'filetype' option includes 'chezmoitmpl'
            if string.find(vim.bo.filetype, 'chezmoitmpl') then
              return true
            end
          end,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = 'v',
            node_decremental = 'V',
            -- init_selection = '<A-Up>',
            -- scope_incremental = '<A-Right>',
          },
        },

        autotag = {
          enable = true,
        },

        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end, 0)
  end,
}
