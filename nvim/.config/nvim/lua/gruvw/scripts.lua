-- ~/.config/nvim/lua/gruvw/scripts.lua

-- Add new line to the end of the file
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  group = vim.api.nvim_create_augroup('UserOnSave', {}),
  pattern = '*',
  callback = function()
    local n_lines = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(n_lines)
    if last_nonblank <= n_lines then vim.api.nvim_buf_set_lines(0,
      last_nonblank, n_lines, true, { '' })
    end
  end,
})

-- Trim ending whitespaces, keep cursor position
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

