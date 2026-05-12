return {
  'rebelot/kanagawa.nvim',
  lazy = require('muratoffalex.config').theme ~= 'kanagawa',
  priority = 1000,
  opts = {
    compile = true,
    background = {
      dark = 'wave',
      light = 'lotus',
    },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none',
          },
        },
      },
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        NormalFloat = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        FloatTitle = { bg = 'none' },

        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- Popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

        WinBarDiffAdded = { fg = theme.vcs.added },
        WinBarDiffRemoved = { fg = theme.vcs.removed },
        WinBarDiffChanged = { fg = theme.vcs.changed },

        OilGitAdded = { fg = theme.vcs.added },
        OilGitModifiedStaged = { fg = theme.syn.string },
        OilGitModifiedUnstaged = { fg = theme.syn.identifier },
        OilGitRenamed = { fg = theme.syn.number },
        OilGitDeleted = { fg = theme.vcs.removed },
        OilGitCopied = { fg = theme.syn.number },
        OilGitConflict = { fg = theme.syn.special2 },
        OilGitUntracked = { fg = theme.syn.special1 },
        OilGitIgnored = { fg = theme.syn.comment },

        -- for cmdline commands
        -- Problem: commands I enter in uppercase have a red color, which is confusing.
        -- Solution: change the color to blue.
        ['@function.macro.vim'] = { fg = theme.syn.fun },
      }
    end,
  },
  config = function(_, opts)
    require('kanagawa').setup(opts)
    vim.cmd.colorscheme 'kanagawa'
  end,
}
