-- ~/.config/nvim/lua/gruvw/scripts.lua

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Trim ending whitespaces and empty lines, keep cursor position
autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function(ev)
    local ignore_filetype = { "markdown", "latex", "tex", "yaml" }
    local save_cursor = vim.fn.getpos(".")
    if not vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
      vim.cmd([[%s/\s\+$//e]])         -- spaces at end of line
    end
    vim.cmd([[%s#\($\n\s*\)\+\%$##e]]) -- empty lines EOF
    vim.fn.setpos(".", save_cursor)
  end,
})

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
autocmd("BufWinEnter", {
  group = augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then vim.cmd.wincmd("L") end
  end
})

-- Remember last place cursor on open, https://github.com/neovim/neovim/issues/16339
-- Adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = { "quickfix", "nofile", "help", }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", }
local function restore_cursor()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    -- Reset cursor to first line
    vim.cmd [[normal! gg]]
    return
  end

  -- If a line has already been specified on the command line, we are done nvim file +num
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
      vim.cmd([[normal! g`"]])
      -- Try to center
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd([[normal! g`"zz]])
    else
      vim.cmd([[normal! G'"<c-e>]])
    end
  end
end
autocmd({ "BufWinEnter", "FileType" }, {
  group = augroup("nvim-lastplace", {}),
  callback = restore_cursor
})

-- LSP Diagnostics on save
-- autocmd({ "TextChanged", "TextChangedI", }, {
--   callback = function(args)
--     vim.diagnostic.disable(args.buf)
--   end
-- })
-- autocmd({ "BufWinEnter", "BufNew", "BufWrite" }, {
--   callback = function(args)
--     vim.diagnostic.enable(args.buf)
--   end
-- })

-- Format options (don't comment continuation in normal mode), load debuger config
autocmd({ "BufNewFile", "BufRead" }, {
  callback = function(args)
    vim.opt.formatoptions = "jctlq"

    -- Load JSON config
    local load_opts = {
      cppdbg = { "c", "cpp" },
    }

    -- Load debuger config
    local root = require("nvim-rooter").get_root()
    -- if root ~= nil then
    --   require("dap.ext.vscode").load_launchjs(root .. "/launch.json", load_opts)
    -- end
  end
})

-- Format on save (autoformat)
autocmd({ "BufWritePre" }, {
  pattern = { "*.dart", "*.rs", },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})

-- Custom filetypes
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.typ", },
  callback = function()
    vim.o.filetype = "typst"
  end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.arb", },
  callback = function()
    vim.o.filetype = "arb"
  end,
})

-- Auto LSP enable
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.py", "*.dart", "*.rs", "*.lua", "*.go", "*.c", "*.cpp", "*.tex", "*.latex", "*.md", "*.html", "*.css",
    "*.scss", "*.json", "*.typ", "*.go" },
  callback = function()
    if vim.g.lsp_off then
      return
    end

    require("lspconfig")
    vim.cmd([[:LspStart<CR>]])
  end,
})
