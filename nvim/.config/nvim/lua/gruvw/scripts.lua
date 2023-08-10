-- ~/.config/nvim/lua/gruvw/scripts.lua

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Add new line to the end of the file
autocmd({"BufWritePre"}, {
  group = augroup("UserOnSave", {}),
  pattern = "*",
  callback = function()
    -- Should not happen for temporary files (examples: vifm bulk rename, vim-anywhere)
    local buffer_name = vim.fn.expand("%:p")
    if vim.startswith(buffer_name, "/tmp/") then
      return
    end

    local n_lines = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(n_lines)
    if last_nonblank <= n_lines then vim.api.nvim_buf_set_lines(0,
      last_nonblank, n_lines, true, {""})
    end
  end,
})

-- Trim ending whitespaces, keep cursor position
autocmd({"BufWritePre"}, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Autostart in insert mode for new files
vim.cmd("autocmd BufNewFile * startinsert")

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150,
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
