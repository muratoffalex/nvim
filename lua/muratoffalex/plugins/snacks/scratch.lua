return {
  'folke/snacks.nvim',
  keys = {
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Open Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
  },
  opts = {
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
  },
}
