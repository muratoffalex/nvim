local M = {}

M.format_action = function(_)
   local function format_buffer()
      vim.lsp.buf.format {
         -- some tools (like eslint) are slow
         timeout_ms = 5000,
         filter = function(c)
            -- vim.notify('Formatter: ' .. c.name)
            -- vim.notify('Is format: ' .. tostring(c.settings.formatting_enabled ~= false))
            return c.settings.formatting_enabled ~= false
         end,
      }
   end

   -- Execute with error handling
   local ok, err = pcall(format_buffer)
   if not ok then
      vim.notify('Format failed: ' .. tostring(err), vim.log.levels.ERROR)
   end
end

return M
