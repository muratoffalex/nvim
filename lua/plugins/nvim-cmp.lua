return {
   -- Autocompletion
   'hrsh7th/nvim-cmp',
   dependencies = {
      {
         'garymjr/nvim-snippets',
         opts = {
            friendly_snippets = true,
         },
         dependencies = { 'rafamadriz/friendly-snippets' },
      },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
   },
   opts = function()
      local cmp = require 'cmp'

      return {
         snippet = {
            expand = function(args)
               vim.snippet.expand(args.body)
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
               else
                  fallback()
               end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_prev_item()
               else
                  fallback()
               end
            end, { 'i', 's' }),
         },
         sources = {
            { name = 'nvim_lsp' },
            { name = 'snippets' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'lazydev', group_index = 0 },
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
