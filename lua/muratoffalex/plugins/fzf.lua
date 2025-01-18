return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  cmd = 'FzfLua',
  keys = {
    { '<leader>:', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
    { '<leader>fq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix List' },
    { '<leader>fw', '<cmd>FzfLua live_grep_native<cr>', desc = 'Live grep' },
    { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find files' },
    { '<leader><space>', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Find existing buffers' },
    { '<leader>fg', '<cmd>FzfLua git_files<cr>', desc = 'Find git files' },
    { '<leader>fr', '<cmd>FzfLua resume<cr>', desc = 'Search Resume' },
    { '<leader>fs', '<cmd>FzfLua git_status<CR>', desc = 'Git status' },
    { '<leader>fc', '<cmd>FzfLua grep_cword<cr>', desc = 'Search current word' },
    { '<leader>fb', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Fuzzily search in current buffer' },
    { '<leader>fo', '<cmd>FzfLua oldfiles<cr>', desc = 'Find recently opened files' },

    -- lsp
    { '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Diagnostics' },
    {
      'gd',
      '<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>',
      desc = 'Goto Definition',
    },
    {
      'gr',
      '<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>',
      desc = 'References',
      nowait = true,
    },
    {
      'gI',
      '<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>',
      desc = 'Goto Implementation',
    },
    {
      'gy',
      '<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>',
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
  opts = function()
    local fzf = require 'fzf-lua'
    local actions = fzf.actions
    local config = fzf.config

    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
    config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
    config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
    config.defaults.keymap.fzf['ctrl-x'] = 'jump'
    config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
    config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
    config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
    config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

    return {
      'default-title',
      fzf_colors = true,
      fzf_opts = {
        ['--no-scrollbar'] = true,
      },
      defaults = {
        formatter = 'path.filename_first',
        -- formatter = 'path.dirname_first',
      },
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { '┃', '' },
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
}
