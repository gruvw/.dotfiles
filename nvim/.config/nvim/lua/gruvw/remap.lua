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

-- Plugins remap

-- Telescope
keymap("n", "<leader>tf", [[:lua require("telescope.builtin").find_files()<CR>]], remap)
keymap("n", "<leader>tg", [[:lua require("telescope.builtin").live_grep()<CR>]], remap)
keymap("n", "<leader>tu", [[:lua require("telescope").extensions.undo.undo()<CR>]], remap)

-- Harpoon
-- From the quickmenu, open a file in: a vertical split with <C-v>, a horizontal split with <C-x>, a new tab with <C-t>
keymap("n", "<leader>ha", [[:lua require("harpoon.mark").add_file()<CR>]], remap)
keymap("n", "<leader>hm", [[:lua require("harpoon.ui").toggle_quick_menu()<CR>]], remap)
keymap("n", "<leader>hh", [[:lua require("harpoon.ui").nav_file(1)<CR>]], remap)
keymap("n", "<leader>ht", [[:lua require("harpoon.ui").nav_file(2)<CR>]], remap)
keymap("n", "<leader>hn", [[:lua require("harpoon.ui").nav_file(3)<CR>]], remap)
keymap("n", "<leader>hs", [[:lua require("harpoon.ui").nav_file(4)<CR>]], remap)

-- Nvim-tree
keymap("n", "<leader>f", [[:lua require("nvim-tree.api").tree.toggle()<CR>]], remap)
