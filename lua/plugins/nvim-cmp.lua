return {
   -- Autocompletion
   'hrsh7th/nvim-cmp',
   version = false,
   dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
   },
   lazy = true,
   event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
   opts = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      return {
         snippet = {
            expand = function(args)
               require('luasnip').lsp_expand(args.body)
            end,
         },
         mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm { select = false },
            ['<A-CR>'] = cmp.mapping.confirm {
               behavior = cmp.ConfirmBehavior.Replace,
               select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_next_item()
               elseif luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
               else
                  fallback()
               end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_prev_item()
               elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
               else
                  fallback()
               end
            end, { 'i', 's' }),
         },
         sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'codeium' },
            { name = 'lazydev', group_index = 0 },
         },
         formatting = {
            format = require('lspkind').cmp_format {
               mode = 'symbol', -- show only symbol annotations
               maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
               ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

               symbol_map = { Codeium = '' },
            },
         },
      }
   end,
   config = function(_, opts)
      for _, source in ipairs(opts.sources) do
         source.group_index = source.group_index or 1
      end
      require('cmp').setup(opts)
   end,
}
