-- ~/.config/nvim/lua/gruvw/remap.lua

local keymap = vim.api.nvim_set_keymap
local remap = {noremap = true, silent = true}

-- Remap esc to jk
-- keymap("i", "jk", "<Esc>", {})

-- Easy save/quit
keymap("n", "Zs", ":w<CR>", remap)
keymap("n", "Zq", ":q<CR>", remap)
keymap("n", "Zz", ":wq<CR>", remap)

-- Empty current line
keymap("n", "<BS>", "0D", remap)

-- New empty line normal mode
keymap("n", "<CR>", "o<Esc>", remap)

-- Line numbers relative toggle
keymap("n", "<C-;>", ":set relativenumber!<CR>", remap)

-- Go to first character of line with gg and G
keymap("n", "gg", "gg0", remap)
keymap("n", "G", "G0", remap)

-- Yank the whole buffer content to "+
keymap("n", "yA", ":%y+<CR>", remap)

-- Functions remap
keymap("n", "<leader>D", ":lua insert_date()<CR>", remap)
