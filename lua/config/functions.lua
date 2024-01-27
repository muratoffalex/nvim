local M = {}

function M.smart_dd()
    local current_line = vim.api.nvim_get_current_line()

    if current_line:match("^%s*$") then
        return '"_dd'
    else
        return "dd"
    end
end

return M
