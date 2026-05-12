return {
  {
    'saghen/blink.cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'rafamadriz/friendly-snippets',
      'xzbdmw/colorful-menu.nvim',
      'obsidian-nvim/obsidian.nvim',
    },
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        preset = 'default',
      },

      keymap = {
        preset = 'enter',
        ['<C-r>'] = { 'show', 'fallback' },
        ['<C-g>'] = { 'select_and_accept' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<F1>'] = {
          function(cmp)
            cmp.accept { index = 1 }
          end,
        },
        ['<F2>'] = {
          function(cmp)
            cmp.accept { index = 2 }
          end,
        },
        ['<F3>'] = {
          function(cmp)
            cmp.accept { index = 3 }
          end,
        },
        ['<F4>'] = {
          function(cmp)
            cmp.accept { index = 4 }
          end,
        },
        ['<F5>'] = {
          function(cmp)
            cmp.accept { index = 5 }
          end,
        },
        ['<F6>'] = {
          function(cmp)
            cmp.accept { index = 6 }
          end,
        },
        ['<F7>'] = {
          function(cmp)
            cmp.accept { index = 7 }
          end,
        },
        ['<F8>'] = {
          function(cmp)
            cmp.accept { index = 8 }
          end,
        },
        ['<F9>'] = {
          function(cmp)
            cmp.accept { index = 9 }
          end,
        },
        ['<F10>'] = {
          function(cmp)
            cmp.accept { index = 10 }
          end,
        },
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
      },

      cmdline = {
        enabled = true,
        keymap = {
          preset = 'cmdline',
          ['<Right>'] = false,
          ['<Left>'] = false,
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function(_)
              return vim.fn.getcmdtype() == ':'
            end,
            draw = {
              columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            },
          },
          ghost_text = { enabled = true },
        },
      },

      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              item_idx = {
                text = function(ctx)
                  if ctx.idx <= 10 then
                    return tostring(ctx.idx)
                  end

                  return '  '
                end,
                highlight = 'Comment',
              },
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
          'codecompanion',
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
            min_keyword_length = 2,
            max_items = 10,
          },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        },
      },
    },
    signature = { enabled = true },
    opts_extend = { 'sources.default' },
  },
  {
    'saghen/blink.cmp',
    opts = function(_, opts)
      local conf = require 'muratoffalex.config'
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = vim.tbl_extend('force', opts.appearance.kind_icons or {}, conf.icons.kinds)
    end,
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
