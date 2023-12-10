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
         --s = s .. '[' .. k .. '] = ' .. M.dump(v) .. ','
         s = s .. M.dump(v) .. separator
      end

      return s:sub(1, -2)
   else
      return tostring(o)
   end
end

return M
