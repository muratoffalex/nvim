return {
  require 'muratoffalex.plugins.snacks.picker',
  require 'muratoffalex.plugins.snacks.scratch',

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      {
        'gb',
        function()
          Snacks.gitbrowse.open()
        end,
        desc = 'Git browse',
        mode = { 'n', 'v' },
      },
      {
        '<leader>nh',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Show notifications history',
      },
    },
    ---@type snacks.Config
    opts = {
      image = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      words = { enabled = true },
      gitbrowse ={
        enabled = true,
        url_patterns = {
          ['forge%.'] = {
            branch = '/src/branch/{branch}',
            file = '/src/branch/{branch}/{file}#L{line_start}-L{line_end}',
            permalink = '/src/commit/{commit}/{file}#L{line_start}-L{line_end}',
            commit = '/commit/{commit}',
          },
        },
      },
      notifier = {
        enabled = true,
        style = 'compact',
        padding = false,
      },
      ---@type table<string, snacks.win.Config>
      styles = {
        -- START: for tokyonight
        scratch = {
          relative = 'editor',
          wo = { winhighlight = 'NormalFloat:NormalFloat,SignColumn:NormalFloat' },
        },
        notification_history = {
          relative = 'editor',
          wo = { winhighlight = 'NormalFloat:NormalFloat,SignColumn:NormalFloat' },
        },
        -- END: for tokyonight
        notification = {
          relative = 'editor',
          wo = { wrap = true },
        },
      },
    },
  },
}
