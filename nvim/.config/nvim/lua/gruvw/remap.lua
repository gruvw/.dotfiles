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

-- Copy vim message
keymap("n", "yM", ":let @+=trim(execute('1messages')) <bar> echo 'copied' <CR>", remap)

-- Functions remap
keymap("n", "<leader>D", ":lua insert_date()<CR>", remap)

-- Plugins remap

-- Telescope (s)
keymap("n", "<leader>sf", [[:lua require("telescope.builtin").find_files()<CR>]], remap)
keymap("n", "<leader>sg", [[:lua require("telescope.builtin").live_grep()<CR>]], remap)
keymap("n", "<leader>su", [[:lua require("telescope").extensions.undo.undo()<CR>]], remap)
keymap("n", "<leader>sw", [[:lua require("telescope").extensions.workspaces.workspaces()<CR>]], remap)

-- Harpoon (j)
-- From the quickmenu, open a file in: a vertical split with <C-v>, a horizontal split with <C-x>, a new tab with <C-t>
keymap("n", "<leader>ja", [[:lua require("harpoon.mark").add_file()<CR>]], remap)
keymap("n", "<leader>jm", [[:lua require("harpoon.ui").toggle_quick_menu()<CR>]], remap)
keymap("n", "<leader>jh", [[:lua require("harpoon.ui").nav_file(1)<CR>]], remap)
keymap("n", "<leader>jt", [[:lua require("harpoon.ui").nav_file(2)<CR>]], remap)
keymap("n", "<leader>jn", [[:lua require("harpoon.ui").nav_file(3)<CR>]], remap)
keymap("n", "<leader>js", [[:lua require("harpoon.ui").nav_file(4)<CR>]], remap)

-- Nvim-tree (t)
keymap("n", "<leader>t", [[:lua require("nvim-tree.api").tree.toggle()<CR>]], remap)

-- Git (g)
keymap("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", remap)
keymap("n", "<leader>gg", ":G<CR>", remap)

-- Code (c)
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set("n", "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.keymap.set("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set("n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.keymap.set("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.keymap.set("n", "<leader>co", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.keymap.set("n", "<leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.keymap.set({"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    vim.keymap.set("n", "<leader>ce", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.keymap.set("n", "<leader>cn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    vim.keymap.set("n", "<leader>cN", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  end
})
keymap("n", "<leader>ct", ":TSContextToggle<CR>", remap)
vim.keymap.set({"v", "n"}, "<leader>cc", [[:CommentToggle<CR>]], opts)

-- LuaSnip
vim.keymap.set({"i"}, "<C-h>", function() require("luasnip").expand() end, opts)
vim.keymap.set({"i", "s", "n"}, "<C-Tab>", [[<cmd>lua require("luasnip").expand_or_jump()<CR>]], opts)
vim.keymap.set({"i", "s", "n"}, "<C-S-Tab>", [[<cmd>lua require("luasnip").jump(-1)<CR>]], opts)
