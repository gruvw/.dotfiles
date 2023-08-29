-- ~/.config/nvim/lua/gruvw/scripts.lua

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Trim ending whitespaces and empty lines, keep cursor position
autocmd({"BufWritePre"}, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.cmd([[%s#\($\n\s*\)\+\%$##e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Autostart in insert mode for new files
-- vim.cmd("autocmd BufNewFile * startinsert")

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 300,
        })
    end,
})

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = {"*.txt"},
    callback = function()
        if vim.o.filetype == "help" then vim.cmd.wincmd("L") end
    end
})
