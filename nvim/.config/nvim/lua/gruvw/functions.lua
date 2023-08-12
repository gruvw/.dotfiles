-- ~/.config/nvim/lua/gruvw/functions.lua

-- Insert current date in YYYY_MM_DD format, before cursor
function insert_date()
    local date_format = os.date("%Y_%m_%d")
    vim.api.nvim_put({date_format}, "", false, true)
end
