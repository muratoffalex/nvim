M = {}

M.status = function(bufnr)
  local git_icons = require 'muratoffalex.config'.icons.git

  local icons = {
    removed = git_icons.deleted,
    changed = git_icons.changed,
    added = git_icons.added,
  }
  local signs = bufnr and vim.b[bufnr].gitsigns_status_dict or vim.b.gitsigns_status_dict
  if not signs then return {} end

  local labels = {}
  for name, icon in pairs(icons) do
    local count = tonumber(signs[name])
    if count and count > 0 then
      labels[#labels + 1] = {
        icon .. count .. ' ',
        group = 'WinBarDiff' .. name
      }
    end
  end
  return labels
end

M.status_string = function()
  local labels = M.status()
  local status = {}

  for i = 1, #labels do
    local label = labels[i]
    status[i] = string.format('%%#%s#%s', label.group, label[1])
  end

  return table.concat(status)
end

return M
