local M = {}

-- print table content
M.dump = function(o, redefined_separator)
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

-- ref: https://github.com/LazyVim/LazyVim/blob/5effc77185f94f557809375b5650d427e7171c32/lua/lazyvim/util/mini.lua#L5
M.ai_buffer = function(ai_type)
  local start_line, end_line = 1, vim.fn.line("$")
  if ai_type == "i" then
    -- Skip first and last blank lines for `i` textobject
    local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
    -- Do nothing for buffer with all blanks
    if first_nonblank == 0 or last_nonblank == 0 then
      return { from = { line = start_line, col = 1 } }
    end
    start_line, end_line = first_nonblank, last_nonblank
  end

  local to_col = math.max(vim.fn.getline(end_line):len(), 1)
  return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
end

M.php = require 'muratoffalex.utils.php'

M.template_builders = {
  php = require 'muratoffalex.utils.template_builders.php',
}

return M
