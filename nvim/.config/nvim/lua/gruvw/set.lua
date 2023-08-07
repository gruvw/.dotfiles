-- ~/.config/nvim/lua/gruvw/config.lua

local set = vim.opt

-- Custom options
set.belloff = "all"

-- File encoding
set.encoding = "utf-8"
set.fileencoding = "utf-8"

-- Relative linu numbers
set.number = true
set.relativenumber = true

-- Tabs defaults to 4 spaces
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth  = 4
set.expandtab = true

-- Bar (|) cursor on insert mode
set.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Have the cursor position (line, column) displayed
set.ruler = true

-- Allows to go one more charater with cursor after end of line
set.virtualedit = "onemore"

-- Time in milliseconds to wait for a mapped sequence to complete
set.timeoutlen = 100

-- Undo history
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

-- Matched string is highlighted when searching
set.incsearch = true

-- Enables 24-bit RGB color in the TUI
set.termguicolors = true

-- Keeps a few lines of margin when scrolling
set.scrolloff = 8

-- Swap file to disk time
set.updatetime = 50

-- Add column ruler
-- TODO colorcolumn not showing from config
-- set.colorcolumn = "100"
-- vim.api.nvim_command("highlight ColorColumn ctermbg=8")
