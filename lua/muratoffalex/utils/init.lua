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

M.php = require 'muratoffalex.utils.php'

M.template_builders = {
  php = require 'muratoffalex.utils.template_builders.php',
}

return M
