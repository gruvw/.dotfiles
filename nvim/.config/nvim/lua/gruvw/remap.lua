-- ~/.config/nvim/lua/gruvw/remap.vim

local keymap = vim.api.nvim_set_keymap

-- Set leader key to space
vim.g.mapleader = " "

-- Remap esc to jk
keymap("i", "jk", "<Esc>", {})
