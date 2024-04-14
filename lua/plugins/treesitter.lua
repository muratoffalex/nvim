return {
   -- Highlight, edit, and navigate code
   'nvim-treesitter/nvim-treesitter',
   dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'windwp/nvim-ts-autotag',
      'gbprod/php-enhanced-treesitter.nvim',
   },
   event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
   build = ':TSUpdate',
   config = function()
      -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
      vim.defer_fn(function()
         require('ts_context_commentstring').setup {}
         vim.g.skip_ts_context_commentstring_module = true

         require('nvim-treesitter.configs').setup {
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = {
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
            },

            -- Autoinstall languages that are not installed. Defaults to false
            auto_install = true,

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
               select = {
                  enable = true,
                  lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                  keymaps = {
                     -- You can use the capture groups defined in textobjects.scm
                     ['aa'] = '@parameter.outer',
                     ['ia'] = '@parameter.inner',
                     ['af'] = '@function.outer',
                     ['if'] = '@function.inner',
                     ['ac'] = '@class.outer',
                     ['ic'] = '@class.inner',
                     ['ii'] = '@conditional.inner',
                     ['ai'] = '@conditional.outer',
                     ['il'] = '@loop.inner',
                     ['al'] = '@loop.outer',
                     ['at'] = '@comment.outer',
                  },
               },
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
