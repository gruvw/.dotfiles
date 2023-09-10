-- ~/.config/nvim/lua/gruvw/functions.lua

-- Insert current date in YYYY_MM_DD format, before cursor
function insert_date()
    local date_format = os.date("%Y_%m_%d")
    vim.api.nvim_put({date_format}, "", false, true)
end

-- Run build / restart
function run_build()
    if vim.bo.filetype == "dart" then
        vim.cmd("FlutterRun")
    end
end

function run_restart()
    if vim.bo.filetype == "dart" then
        vim.cmd("FlutterRestart")
    end
end
