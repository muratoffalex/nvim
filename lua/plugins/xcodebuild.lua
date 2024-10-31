return {
   'wojciech-kulik/xcodebuild.nvim',
   dependencies = {
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
   },
   ft = { 'swift', 'objective-c', 'objective-cpp' },
   keys = {
      {
         '<leader>cx',
         desc = 'Xcodebuild',
      },
   },
   config = function()
      require('xcodebuild').setup {
         integrations = {
            neo_tree = {
               enabled = true,      -- enable updating Xcode project files when using neo-tree.nvim
               guess_target = true, -- guess target for the new file based on the file path
            },
            nvim_tree = {
               enabled = false,
            },
         },
      }

      -- Automatically refresh files when changed outside of vim
      -- https://github.com/wojciech-kulik/xcodebuild.nvim/discussions/36
      -- NOTE: this is expensive on weak machines with many opened buffers
      vim.opt.autoread = true
      vim.fn.timer_start(10000, function()
         vim.cmd 'silent! checktime'
      end, { ['repeat'] = -1 })

      vim.keymap.set('n', '<leader>cxl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild Logs' })
      vim.keymap.set('n', '<leader>cxb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build Project' })
      vim.keymap.set('n', '<leader>cxr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run Project' })
      vim.keymap.set('n', '<leader>cxt', '<cmd>XcodebuildTest<cr>', { desc = 'Run Tests' })
      vim.keymap.set('n', '<leader>cxT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run This Test Class' })
      vim.keymap.set('n', '<leader>cX', '<cmd>XcodebuildPicker<cr>', { desc = 'Show All Xcodebuild Actions' })
      vim.keymap.set('n', '<leader>cxd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select Device' })
      vim.keymap.set('n', '<leader>cxp', '<cmd>XcodebuildSelectTestPlan<cr>', { desc = 'Select Test Plan' })
      vim.keymap.set('n', '<leader>cxc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code Coverage' })
      vim.keymap.set('n', '<leader>cxC', '<cmd>XcodebuildShowCodeCoverageReport<cr>',
         { desc = 'Show Code Coverage Report' })
      vim.keymap.set('n', '<leader>cxq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })
   end,
}
