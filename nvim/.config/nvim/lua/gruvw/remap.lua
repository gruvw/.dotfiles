-- ~/.config/nvim/lua/gruvw/remap.lua

local keymap = vim.keymap.set
local remap = {noremap = true, silent = true}

-- Easy save/quit
keymap("n", "Zs", ":w<CR>", remap)
keymap("n", "Zq", ":q<CR>", remap)
keymap("n", "Zz", ":wq<CR>", remap)

-- Empty current line
keymap("n", "<BS>", "0D", remap)

-- New empty line normal mode
keymap("n", "g<CR>", "o<Esc>0D", remap)

-- No space inserted by J, with a single space for gJ
keymap("n", "J", "j_d0kgJ", remap)
keymap("n", "gJ", "j_d0kgJi<space><Esc>", remap)

-- Execute line under custor as cmd
keymap("n", "<C-x>", ":exec getline('.')<CR>", remap)

-- Line numbers relative toggle
keymap("n", "<C-;>", ":set relativenumber!<CR>", remap)

-- Toggle invisible characters visibility
keymap("n", "<C-.>", ":set list!<CR>", remap)

-- Go to first character of line with gg and G
keymap("n", "gg", "gg0", remap)
keymap("n", "G", "G0", remap)

-- Tab as indent, https://vi.stackexchange.com/questions/42945/indentkeys-tab-behavior
keymap("i", "<Tab>", [[getline(".") == "" && line(".") != 1 ? (line(".") != line("$") ? "\\<Esc>\\"_ddko" : "\\<Esc>\\"_ddo") : "\\<Tab>"]], {expr = true, noremap = true})

-- Full file format
keymap("n", "=A", "gg=G''", remap)

-- Yank the whole buffer content to "+
keymap("n", "yA", ":%y+<CR>", remap)

-- Copy vim message
keymap("n", "yM", ":let @+=trim(execute('1messages')) <bar> echo 'copied'<CR>", remap)

-- Terminal normal mode, close
keymap("t", "<C-t>", [[<C-\><C-n>]], remap)
keymap("t", "<C-c>", [[<C-\><C-n>:q<CR>]], remap)

-- Open links
keymap("n", "gx", [[:silent execute "!open " . shellescape(expand("<cfile>"), 1)<CR>]], remap)

-- Open terminal in new WM window
keymap("n", "<leader><CR>", [[:silent exec "!nohup kitty &>/dev/null &"<CR>]], remap)

-- Functions remap
keymap("n", "<leader>fD", ":lua insert_date()<CR>", remap)

-- Plugins remap

-- Telescope, search (s)
keymap("n", "<leader>sf", [[:lua require("telescope.builtin").find_files()<CR>]], remap)
keymap("n", "<leader>sg", [[:lua require("telescope.builtin").live_grep()<CR>]], remap)
keymap("n", "<leader>su", [[:lua require("telescope").extensions.undo.undo()<CR>]], remap)
keymap("n", "<leader>sw", [[:lua require("telescope").extensions.workspaces.workspaces()<CR>]], remap)
keymap("n", "<leader>sj", [[:lua require("telescope").extensions.harpoon.marks()<CR>]], remap)

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
keymap("n", "<leader>gn", [[:lua require("gitsigns").next_hunk()<CR>]], remap)
keymap("n", "<leader>gN", [[:lua require("gitsigns").prev_hunk()<CR>]], remap)
keymap("n", "<leader>gs", [[:lua require("gitsigns").stage_hunk()<CR>]], remap)
keymap("n", "<leader>gu", [[:lua require("gitsigns").undo_stage_hunk()<CR>]], remap)
keymap("n", "<leader>gg", ":G<CR>", remap)

-- Code (c)
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP mapping",
  callback = function(event)
    local opts = {buffer = event.buf}

    -- Format
    vim.api.nvim_buf_create_user_command(
      event.buf,
      "LspFormat",
      function() vim.lsp.buf.format() end,
      {desc = "Format buffer with language server"}
    )

    -- LSP buffer actions
    keymap("n", "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap("n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap("n", "<leader>co", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "<leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    keymap({"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
    keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    -- Diagnostic
    keymap("n", "<leader>ce", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap("n", "<leader>cn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    keymap("n", "<leader>cN", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  end
})
keymap("n", "<leader>ct", ":TSContextToggle<CR>", remap)
keymap({"v", "n"}, "<leader>cl", [[:CommentToggle<CR>]], opts)

-- LuaSnip
-- Jump to $0, https://github.com/L3MON4D3/LuaSnip/issues/562#issuecomment-1233122825
function snip_jump_end()
  local ls = require("luasnip")
  local session = require("luasnip.session")
	local current = session.current_nodes[vim.api.nvim_get_current_buf()]
  local snip = current and current.parent.snippet or nil
  local end_node = snip.insert_nodes[0]

  while end_node and ls.jumpable(1) do
    local current = session.current_nodes[vim.api.nvim_get_current_buf()]
    if current == end_node then
      break
    end
    ls.jump(1)
  end
end
keymap({"i"}, "<C-e>", [[<cmd>lua require("luasnip").expand()<CR>]], {})
keymap({"i", "s", "n"}, "<C-Tab>", [[<cmd>lua require("luasnip").jump(1)<CR>]], opts)
keymap({"i", "s", "n"}, "<C-S-Tab>", [[<cmd>lua require("luasnip").jump(-1)<CR>]], opts)
keymap({"i", "s", "n"}, "<C-0>", snip_jump_end, opts)

-- Open floating terminal, enable line numbers in float (autocmd do not work)
keymap("n", "<leader>T", [[<cmd>lua require("toggleterm").toggle()<CR><cmd>setlocal number relativenumber<CR><cmd>:startinsert<CR>]], opts)

-- Run (r)
keymap("n", "<leader>ro", [[:lua require("overseer").toggle()<CR>]], remap)
keymap("n", "<leader>rr", [[:lua require("overseer").run_template()<CR>]], remap)
keymap("n", "<leader>rb", [[:lua require("overseer").run_template({tags = {require("overseer").TAG.BUILD}})<CR>]], remap)
keymap("n", "<leader>rt", [[:lua require("overseer").run_template({tags = {require("overseer").TAG.TEST}})<CR>]], remap)
keymap("n", "<leader>rl", function()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({recent_first = true})
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, remap)
