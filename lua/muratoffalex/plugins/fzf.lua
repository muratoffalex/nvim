return {
  'ibhagwan/fzf-lua',
  enabled = false,
  dependencies = { 'echasnovski/mini.icons' },
  cmd = 'FzfLua',
  opts = function()
    local fzf = require 'fzf-lua'
    local actions = fzf.actions
    local config = fzf.config

    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
    config.defaults.keymap.fzf['ctrl-b'] = 'half-page-up'
    config.defaults.keymap.fzf['ctrl-f'] = 'half-page-down'
    -- config.defaults.keymap.fzf['ctrl-x'] = 'jump'
    config.defaults.keymap.fzf['ctrl-d'] = 'preview-page-down'
    config.defaults.keymap.fzf['ctrl-u'] = 'preview-page-up'
    config.defaults.keymap.builtin['<c-d>'] = 'preview-page-down'
    config.defaults.keymap.builtin['<c-u>'] = 'preview-page-up'

    config.defaults.keymap.builtin['<c-p>'] = 'toggle-preview'
    config.defaults.keymap.builtin['<a-m>'] = 'toggle-fullscreen'

    return {
      'ivy',
      fzf_colors = true,
      fzf_opts = {
        ['--no-scrollbar'] = true,
      },
      defaults = {
        formatter = 'path.filename_first',
        -- formatter = 'path.dirname_first',
      },
      winopts = {
        height = 0.5,
        title_pos = 'left',
        backdrop = 100,
        preview = {
          layout = 'flex',
          title_pos = 'left',
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ['ctrl-h'] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ['ctrl-h'] = { actions.toggle_hidden },
        },
      },
      -- oldfiles = {
      --   include_current_session = false,
      -- },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return 'TroubleIcon' .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. '\t'
          end,
          child_prefix = false,
        },
      },
    }
  end,
  keys = {
    { '<leader>:', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
    { '<leader>fq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix List' },
    { '<leader>fw', '<cmd>FzfLua live_grep_native<cr>', desc = 'Live grep' },
    { '<leader>ff', '<cmd>FzfLua files git_icons=false<cr>', desc = 'Find files' },
    { '<leader><space>', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Find existing buffers' },
    { '<leader>fg', '<cmd>FzfLua git_files<cr>', desc = 'Find git files' },
    { '<leader>fr', '<cmd>FzfLua resume<cr>', desc = 'Search Resume' },
    { '<leader>fs', '<cmd>FzfLua git_status<CR>', desc = 'Git status' },
    { '<leader>fc', '<cmd>FzfLua grep_cword<cr>', desc = 'Search current word' },
    { '<leader>fb', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Fuzzily search in current buffer' },
    { '<leader>fo', '<cmd>FzfLua oldfiles git_icons=false<cr>', desc = 'Find recently opened files' },

    -- lsp
    { '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Diagnostics' },
    {
      'gd',
      '<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>',
      desc = 'Goto Definition',
    },
    {
      'gD',
      '<cmd>FzfLua lsp_declarations     jump1=true ignore_current_line=true<cr>',
      desc = 'Goto Declaration',
    },
    {
      'gr',
      '<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>',
      desc = 'References',
      nowait = true,
    },
    {
      'gI',
      '<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>',
      desc = 'Goto Implementation',
    },
    {
      'gy',
      '<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>',
      desc = 'Goto Type Definition',
    },

    {
      '<leader>ds',
      function()
        require('fzf-lua').lsp_document_symbols()
      end,
      desc = 'Goto Symbol',
    },
    {
      '<leader>ws',
      function()
        require('fzf-lua').lsp_live_workspace_symbols()
      end,
      desc = 'Goto Symbol (Workspace)',
    },
  },
}
