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

-- Remember last place cursor on open, https://github.com/neovim/neovim/issues/16339
-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = {"quickfix", "nofile", "help"}
local ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"}
local function restore_cursor()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    -- reset cursor to first line
    vim.cmd[[normal! gg]]
    return
  end

  -- If a line has already been specified on the command line, we are done
  --   nvim file +num
  if vim.fn.line(".") > 1 then
    return
  end

  local last_line = vim.fn.line([['"]])
  local buff_last_line = vim.fn.line("$")

  -- If the last line is set and the less than the last line in the buffer
  if last_line > 0 and last_line <= buff_last_line then
    local win_last_line = vim.fn.line("w$")
    local win_first_line = vim.fn.line("w0")
    -- Check if the last line of the buffer is the same as the win
    if win_last_line == buff_last_line then
      -- Set line to last line edited
      vim.cmd[[normal! g`"]]
      -- Try to center
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd[[normal! g`"zz]]
    else
      vim.cmd[[normal! G'"<c-e>]]
    end
  end
end

vim.api.nvim_create_autocmd({"BufWinEnter", "FileType"}, {
  group = vim.api.nvim_create_augroup("nvim-lastplace", {}),
  callback = restore_cursor
})

-- LSP Diagnostics on save
vim.api.nvim_create_autocmd({"BufNew", "InsertEnter"}, {
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end
})
vim.api.nvim_create_autocmd({"BufWrite"}, {
  callback = function(args)
    vim.diagnostic.enable(args.buf)
  end
})
