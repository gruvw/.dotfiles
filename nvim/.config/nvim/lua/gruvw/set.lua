-- ~/.config/nvim/lua/gruvw/set.lua

local set = vim.opt

-- Custom options
set.belloff = "all"

-- File encoding
set.encoding = "utf-8"

-- Relative linu numbers
set.number = true
set.relativenumber = true

-- Tabs defaults to 4 spaces
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth  = 4
set.expandtab = true

-- Automatic indentation
set.autoindent = true
set.smartindent = true
set.cindent = true
vim.cmd("filetype plugin indent on")
-- set.indentkeys = "0{,0},0),0],:,0#,!^F,o,O,e,!0<Tab>"
-- set.cinkeys = "0{,0},0),0],:,0#,!^F,o,O,e,!0<Tab>"

-- Bar (|) cursor on insert mode
set.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Have the cursor position (line, column) displayed
set.ruler = true

-- Allows to go one more charater with cursor after end of line
set.virtualedit = "onemore"

-- Time in milliseconds to wait or a mapped sequence to complete
set.timeoutlen = 600

-- Swap file to disk time (nothing typed)
set.updatetime = 500

-- Undo history
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

-- Matched string is highlighted when searching
set.incsearch = true
set.hlsearch = false

-- Search is case insensitive by default
set.ignorecase = true
set.smartcase = true

-- Enables 24-bit RGB color in the TUI
set.termguicolors = true

-- Keeps a few lines of margin when scrolling
set.scrolloff = 8
set.sidescrolloff = 16

-- Add column ruler
-- vim.wo.colorcolumn = "100"
set.wrap = true

-- Show command
set.showcmd = true

-- Highlight current line
set.cursorline = true

-- Disable folds by default
set.foldenable = false

-- Asks before leaving file with unsaved changes
set.confirm = true

-- Only one sign column
set.signcolumn = "yes:1"

-- Open new buffers on the right
set.splitright = true

-- Format options (don't insert comment leader in normal mode), also in autocmd (see scripts.lua)
set.formatoptions = "jctrlq"

-- Default to fish shell
set.shell = "fish"

-- Disable netrw (nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Invisible characters
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("tab:-->")

-- Prefered TEX flavor
vim.g.tex_flavor = "latex"
