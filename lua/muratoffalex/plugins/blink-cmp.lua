return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'xzbdmw/colorful-menu.nvim',
      'Kaiser-Yang/blink-cmp-avante',
      'obsidian-nvim/obsidian.nvim'
    },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-r>'] = { 'show', 'fallback' },
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<A-1>'] = {
          function(cmp)
            cmp.accept { index = 1 }
          end,
        },
        ['<A-2>'] = {
          function(cmp)
            cmp.accept { index = 2 }
          end,
        },
        ['<A-3>'] = {
          function(cmp)
            cmp.accept { index = 3 }
          end,
        },
        ['<A-4>'] = {
          function(cmp)
            cmp.accept { index = 4 }
          end,
        },
        ['<A-5>'] = {
          function(cmp)
            cmp.accept { index = 5 }
          end,
        },
        ['<A-6>'] = {
          function(cmp)
            cmp.accept { index = 6 }
          end,
        },
        ['<A-7>'] = {
          function(cmp)
            cmp.accept { index = 7 }
          end,
        },
        ['<A-8>'] = {
          function(cmp)
            cmp.accept { index = 8 }
          end,
        },
        ['<A-9>'] = {
          function(cmp)
            cmp.accept { index = 9 }
          end,
        },
        ['<A-0>'] = {
          function(cmp)
            cmp.accept { index = 10 }
          end,
        },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
      },

      completion = {
        list = {
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= 'cmdline'
            end,
            auto_insert = function(ctx)
              return ctx.mode == 'cmdline'
            end,
          },
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- conbined together in label by colorful-menu.nvim.
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              label = {
                text = require('colorful-menu').blink_components_text,
                highlight = require('colorful-menu').blink_components_highlight,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = false,
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          'dadbod',
          'cmdline',
          'avante',
          'codecompanion',
          'obsidian',
          'obsidian_new',
          'obsidian_tags',
        },
        providers = {
          lsp = {
            -- min_keyword_length = 2, -- Number of characters to trigger provider
            score_offset = 0, -- Boost/penalize the score of the items
          },
          path = {
            min_keyword_length = 0,
          },
          snippets = {
            min_keyword_length = 2,
          },
          buffer = {
            min_keyword_length = 5,
            max_items = 5,
          },
          cmdline = {
            max_items = 10,
          },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
          -- obsidian = { name = 'Obsidian', module = 'obsidian.completion.sources.blink.refs' },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
          },
        },
      },
    },
    signature = { enabled = true },
    opts_extend = { 'sources.default' },
  },
  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
}
