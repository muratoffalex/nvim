local M = {}

-- print table content
function M.dump(o, redefined_separator)
   local separator = redefined_separator or ','
   if type(o) == 'table' then
      local s = ''
      for k, v in pairs(o) do
         if type(k) ~= 'number' then
            k = '"' .. k .. '"'
         end
         s = s .. M.dump(v) .. separator
      end

      return s:sub(1, -1 - string.len(separator))
   else
      return tostring(o)
   end
end

M.git_status = function()
   local gitsigns = vim.b.gitsigns_status_dict or {}
   local added = gitsigns.added or 0
   local removed = gitsigns.removed or 0
   local changed = gitsigns.changed or 0

   local status = {}
   if added > 0 then
      table.insert(status, string.format('%%#WinBarDiffAdded# %d ', added))
   end
   if removed > 0 then
      table.insert(status, string.format('%%#WinBarDiffRemoved# %d ', removed))
   end
   if changed > 0 then
      table.insert(status, string.format('%%#WinBarDiffChanged# %d', changed))
   end

   return table.concat(status)
end

M.php = require 'muratoffalex.utils.php'

M.template_builders = {
   php = require 'muratoffalex.utils.template_builders.php',
}

return M
