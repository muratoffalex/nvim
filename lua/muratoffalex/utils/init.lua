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

M.git_status = function(bufnr)
  local icons = { removed = ' ', changed = ' ', added = ' ' }
  local signs = bufnr and vim.b[bufnr].gitsigns_status_dict or vim.b.gitsigns_status_dict
  local labels = {}
  if signs == nil then
    return labels
  end
  for name, icon in pairs(icons) do
    if tonumber(signs[name]) and signs[name] > 0 then
      table.insert(labels, { icon .. signs[name] .. ' ', group = 'WinBarDiff' .. name })
    end
  end
  return labels
end

M.git_status_string = function()
  local labels = M.git_status()
  local status = {}

  for _, label in ipairs(labels) do
    table.insert(status, string.format("%%#%s#%s", label.group, label[1]))
  end

  return table.concat(status)
end

M.php = require 'muratoffalex.utils.php'

M.template_builders = {
  php = require 'muratoffalex.utils.template_builders.php',
}

return M
