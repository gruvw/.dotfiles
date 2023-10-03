-- ~/.config/nvim/lua/gruvw/remap.lua

local keymap = vim.keymap.set
local remap = { noremap = true, silent = true, }

-- Easy save/quit
keymap("n", "Zs", ":w<CR>", remap)
keymap("n", "Zq", ":q<CR>", remap)
keymap({ "i", "n", }, "<C-c>", "<cmd>:q<CR>", remap)
keymap("n", "ZQ", ":qa<CR>", remap)
keymap("n", "Zz", ":wq<CR>", remap)

-- Empty current line
keymap("n", "<BS>", "0D", remap)

-- New empty line normal mode
keymap("n", "g<CR>", "o<Esc>0D", remap)

-- No space inserted by J, with a single space for gJ
keymap("n", "J", "j_d0kgJ", remap)
keymap("n", "gJ", "j_d0kgJi<space><Esc>", remap)

-- Scrolling
keymap("n", "<C-j>", "10j", remap)
keymap("n", "<C-k>", "10k", remap)

-- Resize
keymap("n", "<C-w><", ":vertical resize +10<CR>", remap)
keymap("n", "<C-w>>", ":vertical resize -10<CR>", remap)
keymap("n", "<C-w>+", ":resize +6<CR>", remap)
keymap("n", "<C-w>-", ":resize -6<CR>", remap)

-- Execute line under custor as cmd
keymap("n", "<C-S-x>", ":exec getline('.')<CR>", remap)

-- Line numbers relative toggle
keymap("n", "<C-;>", ":set relativenumber!<CR>", remap)

-- Toggle invisible characters visibility
keymap("n", "<C-.>", ":set list!<CR>", remap)

-- Go to first character of line with gg and G
keymap("n", "gg", "gg0", remap)
keymap("n", "G", "G0", remap)

-- Tab as indent, https://vi.stackexchange.com/questions/42945/indentkeys-tab-behavior
-- keymap("i", "g<Tab>",
--   [[getline(".") == "" && line(".") != 1 ? (line(".") != line("$") ? "<Esc>ddko" : "<Esc>ddo") : "<Tab>"]],
--   { expr = true, noremap = true, })

-- Full file operations
keymap("n", "=A", "gg=G''", remap)
keymap("n", "dA", "ggdG", remap)
keymap("n", "yA", ":%y+<CR>", remap)
keymap("n", "cA", "ggcG", remap)

-- Yank paths, relative/absolute
keymap("n", "yp", [[:let @+=expand("%") <bar> echo "copied"<CR>]], remap)
keymap("n", "yP", [[:let @+=expand("%:p") <bar> echo "copied"<CR>]], remap)

-- Yank vim message
keymap("n", "yM", [[:let @+=trim(execute('1messages')) <bar> echo "copied"<CR>]], remap)

-- Terminal normal mode, close
keymap("t", "<C-t>", [[<C-\><C-n>]], remap)
keymap("t", "<C-c>", [[<C-\><C-n>:q<CR>]], remap)

-- Open links
-- TODO use nohup here
keymap("n", "gx", [[:silent execute "!open " . shellescape(expand("<cfile>"), 1)<CR>]], remap)

-- Spelling
keymap("n", "zs", ":set spell!<CR>", remap)
keymap("n", "zn", "]s", remap)
keymap("n", "zN", "[s", remap)
keymap("n", "zc", "z=", remap)

-- Open terminal in new WM window
keymap("n", "<leader><CR>", [[:silent exec "!nohup kitty &>/dev/null &"<CR>]], remap)

-- Open VIFM in cwd
keymap("n", "<leader>V", [[:silent exec "!nohup kitty vifm &>/dev/null &"<CR>]], remap)

-- LSP
keymap("n", "<leader>lr", ":LspStart<CR>", remap)
keymap("n", "<leader>ls", ":LspStop<CR>", remap)

-- Functions/macro remap (f)
keymap("n", "<leader>fb", ":w<CR>:lua run_build()<CR>", remap) -- run code
keymap("n", "<leader>fr", ":w<CR>:lua run_restart()<CR>", remap) -- restart code
keymap("n", "<leader>fD", ":lua insert_date()<CR>", remap)
keymap("n", "<leader>fs", "iLucas Jung (IN-BA5 324724)<esc>", remap) -- sign

-- Plugins remap

-- Telescope, search (s)
keymap("n", "<leader>sf", [[:lua require("telescope.builtin").find_files()<CR>]], remap)
keymap("n", "<leader>sg", [[:lua require("telescope.builtin").live_grep()<CR>]], remap)
keymap("n", "<leader>sb", [[:lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>]], remap)
keymap("n", "<leader>sc", [[:lua require("telescope.builtin").commands()<CR>]], remap)
keymap("n", "<leader>sr", [[:lua require("telescope.builtin").resume()<CR>]], remap)
keymap("n", "<leader>su", [[:lua require("telescope").extensions.undo.undo()<CR>]], remap)
keymap("n", "<leader>sw", [[:lua require("telescope").extensions.workspaces.workspaces()<CR>]], remap)
keymap("n", "<leader>sj", [[:lua require("telescope").extensions.harpoon.marks()<CR>]], remap)
keymap("n", "<leader>st", [[:TodoTelescope<CR>]], remap)
keymap("n", "<leader>sy", [[:lua require("telescope").extensions.neoclip.default()<CR>]], remap)
keymap("n", "<leader>sm", [[:lua require("telescope").extensions.macroscope.default()<CR>]], remap)

-- Workspaces (w)
keymap("n", "<leader>wa", [[:lua require("workspaces").add(vim.fn.getcwd(), vim.fn.input("Workspace name: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")))<CR>]], remap)

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
keymap("n", "<leader>gd", [[:lua require("gitsigns").diffthis()<CR>]], remap)
keymap("n", "<leader>gg", ":G<CR>", remap)

-- Code (c)
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP mappings",
  callback = function(event)
    local opts = { buffer = event.buf, }

    -- LSP buffer actions
    keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap("n", "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap("n", "<leader>co", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "<leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    keymap({ "n", "x", }, "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
    keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

    -- Diagnostic
    keymap("n", "<leader>ce", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap("n", "<leader>cn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    keymap("n", "<leader>cN", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  end
})

-- Treesitter context (c)
keymap("n", "<leader>cc", ":TSContextToggle<CR>", remap)

-- Trouble (c)
keymap("n", "<leader>ct", [[:lua require("trouble").toggle()<CR>]], remap)

-- Comment (c)
keymap({ "v", "n", }, "<leader>cl", [[:CommentToggle<CR>]], remap)
keymap("i", "<C-/>", [[<cmd>CommentToggle<CR><esc>A]], remap)

-- LuaSnip
-- Jump to $0, https://github.com/L3MON4D3/LuaSnip/issues/562#issuecomment-1233122825
local function snip_jump_end()
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
keymap({ "i" }, "<C-e>", [[<cmd>lua require("luasnip").expand()<CR>]], {})
keymap({ "i", "s", "n", }, "<C-Tab>", [[<cmd>lua require("luasnip").jump(1)<CR>]], remap)
keymap({ "i", "s", "n", }, "<C-S-Tab>", [[<cmd>lua require("luasnip").jump(-1)<CR>]], remap)
keymap({ "i", "s", "n", }, "<C-0>", snip_jump_end, remap)

-- Open floating terminal (T), enable line numbers in float (autocmd do not work)
keymap("n", "<leader>T", [[<cmd>lua require("toggleterm").toggle()<CR><cmd>setlocal number relativenumber<CR><cmd>:startinsert<CR>]], remap)

-- Open hex edit (H)
keymap("n", "<leader>H", [[:lua require("hex").toggle()<CR>]], remap)

-- Run (r)
keymap("n", "<leader>ro", [[:lua require("overseer").toggle()<CR>]], remap)
keymap("n", "<leader>rr", [[:w<CR>:lua require("overseer").run_template()<CR>]], remap)
keymap("n", "<leader>rb", [[:w<CR>:lua require("overseer").run_template({tags = {require("overseer").TAG.BUILD}})<CR>]], remap)
keymap("n", "<leader>rt", [[:w<CR>:lua require("overseer").run_template({tags = {require("overseer").TAG.TEST}})<CR>]], remap)
keymap("n", "<leader>rl", [[:w<CR>:lua overseer_restart()<CR>]], remap)
keymap("n", "<leader>r<CR>", [[:w<CR>:lua overseer_term()<CR>]], remap)

-- ToDo (o)
keymap("n", "<leader>on", [[:lua require("todo-comments").jump_next()<CR>]], remap)
keymap("n", "<leader>oN", [[:lua require("todo-comments").jump_prev()<CR>]], remap)

-- Nvim DAP (d)
keymap("n", "<leader>dc", function() require("dap").continue() end, remap)
keymap("n", "<leader>dn", function() require("dap").step_over() end, remap)
keymap("n", "<leader>dL", function() require("dap").step_into() end, remap)
keymap("n", "<leader>dH", function() require("dap").step_out() end, remap)
keymap("n", "<leader>db", function() require("dap").toggle_breakpoint() end, remap)
keymap("n", "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, remap)
keymap("n", "<leader>dt", function() require("dap").repl.open() end, remap)
keymap("n", "<leader>dr", function() require("dap").run_last() end, remap)
keymap("n", "<leader>dt", function() require("dap").terminate() require("dapui").close() end, remap)
keymap({"n", "v"}, "<leader>dh", function() require("dap.ui.widgets").hover() end, remap)
keymap({"n", "v"}, "<leader>dp", function() require("dap.ui.widgets").preview() end, remap)
keymap("n", "<leader>do", function() require("dapui").toggle() end, remap)
