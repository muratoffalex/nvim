return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      'gb',
      function()
        Snacks.gitbrowse.open()
      end,
      desc = 'Git browse',
      mode = { 'n', 'x', 'v' },
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
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
    gitbrowse = {
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
    image = { enabled = true },
    picker = {
      layout = 'ivy',
    },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    notifier = {
      enabled = true,
      style = 'compact',
      padding = false,
    },
    rename = { enabled = true },
    words = { enabled = true },
    statuscolumn = {
      enabled = false,
      left = { 'mark', 'git' },
      right = { 'sign', 'fold' },
    },
    scratch = {
      enabled = true,
      win_by_ft = {
        go = {
          keys = {
            ['source'] = {
              '<cr>',
              function(self)
                local file_path = vim.api.nvim_buf_get_name(self.buf)

                -- Run Go file and capture output
                vim.fn.jobstart({ 'go', 'run', file_path }, {
                  stdout_buffered = true,
                  on_stdout = function(_, data)
                    if data then
                      local output = table.concat(data, '\n')
                      if output ~= '' then
                        vim.notify(output, vim.log.levels.INFO)
                      end
                    end
                  end,
                  on_stderr = function(_, data)
                    if data then
                      local error = table.concat(data, '\n')
                      if error ~= '' then
                        vim.notify(error, vim.log.levels.ERROR)
                      end
                    end
                  end,
                })
              end,
              desc = 'Run scratch',
              mode = { 'n', 'x' },
            },
          },
        },
        php = {
          keys = {
            ['source'] = {
              '<cr>',
              function(self)
                local file_path = vim.api.nvim_buf_get_name(self.buf)

                -- Run PHP file and capture output
                vim.fn.jobstart({ 'php', file_path }, {
                  stdout_buffered = true,
                  on_stdout = function(_, data)
                    if data then
                      local output = table.concat(data, '\n')
                      if output ~= '' then
                        vim.notify(output, vim.log.levels.INFO)
                      end
                    end
                  end,
                  on_stderr = function(_, data)
                    if data then
                      local error = table.concat(data, '\n')
                      if error ~= '' then
                        vim.notify(error, vim.log.levels.ERROR)
                      end
                    end
                  end,
                })
              end,
              desc = 'Run scratch',
              mode = { 'n', 'x' },
            },
          },
        },
      },
    },
    ---@type table<string, snacks.win.Config>
    styles = {
      scratch = {
        relative = 'editor',
        wo = { winhighlight = 'NormalFloat:NormalFloat,SignColumn:NormalFloat' },
      },
      notification_history = {
        relative = 'editor',
        wo = { winhighlight = 'NormalFloat:NormalFloat,SignColumn:NormalFloat' },
      },
      notification = {
        relative = 'editor',
        wo = { wrap = true },
      },
    },
  },
}
