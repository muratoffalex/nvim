return {
   'folke/noice.nvim',
   event = 'VeryLazy',
   -- temporarily downgrade
   -- https://github.com/folke/noice.nvim/issues/923
   version = '4.4.7',
   opts = {
      notify = {
         enabled = true,
         view = 'notify',
      },
      lsp = {
         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
         override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
         },
      },
      presets = {
         bottom_search = true,         -- use a classic bottom cmdline for search
         command_palette = true,       -- position the cmdline and popupmenu together
         long_message_to_split = true, -- long messages will be sent to a split
         inc_rename = false,           -- enables an input dialog for inc-rename.nvim
         lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
   },
   dependencies = {
      'MunifTanjim/nui.nvim',
   },
   keys = {
      { '<leader>nd', '<cmd>NoiceDismiss<cr>', desc = 'Noice dismiss' },
   },
   config = function(_, opts)
      -- ref: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == 'lazy' then
         vim.cmd [[messages clear]]
      end
      require('noice').setup(opts)
   end,
}
