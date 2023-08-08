-- ~/.config/nvim/lua/gruvw/remap.vim

local keymap = vim.api.nvim_set_keymap

-- Set leader key to space
vim.g.mapleader = " "

-- Remap esc to jk
keymap("i", "jk", "<Esc>", {})

-- Easy save/quit
keymap("n", "Zs", ":w<CR>", {noremap = true, silent = true})
keymap("n", "Zq", ":q<CR>", {noremap = true, silent = true})
keymap("n", "Zz", ":wq<CR>", {noremap = true, silent = true})

-- Empty current line
keymap("n", "<BS>", "0D", {noremap = true, silent = true})

-- New empty line normal mode
keymap("n", "<CR>", "o<Esc>", {noremap = true, silent = true})

-- Line numbers relative toggle
keymap("n", "<C-;>", ":set relativenumber!<CR>", {noremap = true, silent = true})
