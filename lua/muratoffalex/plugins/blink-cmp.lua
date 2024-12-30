return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = 'enter',
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
        nerd_font_variant = 'mono',
      },

      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          auto_show = function(_)
            return vim.bo.filetype ~= "TelescopePrompt"
          end,
          draw = {
            treesitter = { 'lsp' },
            columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            components = {
              item_idx = {
                text = function(ctx)
                  return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx)
                end,
                highlight = 'CursorLineNr',
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
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == '/' or type == '?' then
            return { 'buffer' }
          end
          -- Commands
          if type == ':' then
            return { 'cmdline' }
          end
          return {}
        end,
        providers = {
          lsp = {
            min_keyword_length = 2, -- Number of characters to trigger porvider
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
            min_keyword_length = 4,
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
