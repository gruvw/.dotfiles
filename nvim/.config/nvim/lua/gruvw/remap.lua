-- ~/.config/nvim/lua/gruvw/remap.lua

local keymap = vim.keymap.set
local remap = { noremap = true, silent = true, }

-- Easy save/quit
keymap("n", "Zs", ":wa<CR>", remap)
keymap("n", "Zq", ":q<CR>", remap)
keymap({ "i", "n", }, "<C-c>", "<cmd>q<CR>", remap)
keymap("n", "ZQ", ":q<CR>", remap)
keymap("n", "Zz", ":wq<CR>", remap)

-- Empty current line
keymap("n", "<BS>", "0D", remap)

-- New empty line normal mode
keymap("n", "g<CR>", "o<Esc>0D", remap)

-- Movement by line
-- keymap("n", "j", "gj", remap)
-- keymap("n", "k", "gk", remap)

-- No space inserted by J, with a single space for gJ
keymap("n", "J", "j_d0kgJ", remap)
keymap("n", "gJ", "j_d0kgJi<space><Esc>", remap)

-- Scrolling
keymap({ "n", "v", }, "<C-j>", "10j", remap)
keymap({ "n", "v", }, "<C-k>", "10k", remap)

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
keymap("n", "gy", [[0"+y$]], remap)
keymap("v", "gy", [["+y]], remap)
keymap("n", "gp", [["+p]], remap)

-- Duplicate to + register (clipboard to system)
keymap("n", "g\"", [[:let @+=@0<CR>]], remap)

-- Better alternate file
keymap("n", "<C-e>", "<C-^>", remap)

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
keymap("n", "zr", "1z=", remap)

-- Yan word
keymap("n", "zy", [["+yiw]], remap)
keymap("n", "zY", [["+yiW]], remap)

-- Clear highlight search
keymap("n", "zh", [[:let @/ = ""<CR>]], remap)

-- Open terminal in new WM window
keymap("n", "<leader><CR>", [[:silent exec "!nohup kitty &>/dev/null &"<CR>]], remap)

-- Open VIFM in cwd
keymap("n", "<leader>v", [[:silent exec "!nohup kitty vifm &>/dev/null &"<CR>]], remap)

-- LSP
keymap("n", "<leader>le", function()
  -- require("flutter-tools")
  -- require("jdtls")
  -- require("dap")
  require("lspconfig")
  vim.cmd([[:LspStart<CR>]])
  vim.g.lsp_off = false
end, remap)
keymap("n", "<leader>ls", function()
  vim.cmd([[:LspStop<CR>]])
  vim.g.lsp_off = true
end, remap)
keymap("n", "<leader>lz", function() vim.diagnostic.enable(false) end, remap)
keymap("n", "<leader>lr", function() vim.diagnostic.enable() end, remap)
-- Copilot
-- keymap("i", "<C-u>", [[copilot#Accept("<CR>")]], {
--   expr = true,
--   replace_keycodes = false
-- })
-- keymap("n", "<leader>Cd", ":Copilot disable<CR>", remap)
-- keymap("n", "<leader>Cp", ":Copilot panel<CR>", remap)

-- Functions/macro remap (f)
keymap("n", "<leader>fb", ":w<CR>:lua run_build()<CR>", remap)       -- run code
keymap("n", "<leader>fr", ":w<CR>:lua run_restart()<CR>", remap)     -- restart code
keymap("n", "<leader>fD", ":lua insert_date()<CR>", remap)
keymap("n", "<leader>fs", "iLucas Jung (IN-BA6 324724)<esc>", remap) -- sign

-- Plugins remap

-- Telescope, search (s)
keymap("n", "<leader>ss", function() require("telescope.builtin").builtin() end, remap)
keymap("n", "<leader>sr", function() require("telescope.builtin").resume() end, remap)
keymap("n", "<leader>sf", function() require("telescope.builtin").find_files() end, remap)
keymap("n", "<leader>sg", function() require("telescope.builtin").live_grep() end, remap)
keymap("n", "<leader>sb", function() require("telescope.builtin").current_buffer_fuzzy_find() end, remap)
keymap("n", "<leader>sc", function() require("telescope.builtin").commands() end, remap)
keymap("n", "<leader>sn", function() require("telescope.builtin").lsp_workspace_symbols() end, remap)
keymap("n", "<leader>sv", function() require("telescope.builtin").treesitter() end, remap)
keymap("n", "<leader>so", function() require("telescope.builtin").oldfiles() end, remap)
keymap("n", "<leader>sh", function() require("telescope.builtin").help_tags() end, remap)
keymap("n", "<leader>su", function() require("telescope").extensions.undo.undo() end, remap)
keymap("n", "<leader>sw", function() require("telescope").extensions.workspaces.workspaces() end, remap)
keymap("n", "<leader>sj", function() require("telescope").extensions.harpoon.marks() end, remap)
keymap("n", "<leader>st", [[:TodoTelescope<CR>]], remap)
keymap("n", "<leader>sy", function() require("telescope").extensions.neoclip.default() end, remap)
keymap("n", "<leader>sm", function() require("telescope").extensions.macroscope.default() end, remap)

-- Workspaces (w)
keymap("n", "<leader>wa", function()
  require("workspaces").add(vim.fn.getcwd(),
    vim.fn.input("Workspace name: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")))
end, remap)

-- Harpoon (j)
-- From the quickmenu, open a file in: a vertical split with <C-v>, a horizontal split with <C-x>, a new tab with <C-t>
keymap("n", "<leader>ja", function() require("harpoon.mark").add_file() end, remap)
keymap("n", "<leader>jm", function() require("harpoon.ui").toggle_quick_menu() end, remap)
keymap("n", "<leader>jh", function() require("harpoon.ui").nav_file(1) end, remap)
keymap("n", "<leader>jt", function() require("harpoon.ui").nav_file(2) end, remap)
keymap("n", "<leader>jn", function() require("harpoon.ui").nav_file(3) end, remap)
keymap("n", "<leader>js", function() require("harpoon.ui").nav_file(4) end, remap)

-- Nvim-tree (t)
keymap("n", "<leader>tt", function() require("nvim-tree.api").tree.toggle() end, remap)
keymap("n", "<leader>tv", function() require("oil").open_float(vim.fn.expand("%:p:h")) end, remap)

-- ToDo (t)
keymap("n", "<leader>tn", [[:lua require("todo-comments").jump_next()<CR>]], remap)
keymap("n", "<leader>tN", [[:lua require("todo-comments").jump_prev()<CR>]], remap)

-- Git (g)
keymap("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", remap)
keymap("n", "<leader>gn", function() require("gitsigns").next_hunk() end, remap)
keymap("n", "<leader>gN", function() require("gitsigns").prev_hunk() end, remap)
keymap("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, remap)
keymap("n", "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, remap)
keymap("n", "<leader>gd", function() require("gitsigns").diffthis() end, remap)
keymap("n", "<leader>gR", function() require("gitsigns").reset_hunk() end, remap)
keymap("n", "<leader>gg", ":G<CR>", remap)

-- Code (c)
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP mappings",
  callback = function(event)
    local opts = { buffer = event.buf, }

    -- LSP buffer actions
    keymap("n", "<leader>cd", function() vim.lsp.buf.definition() end, opts)
    keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
    keymap("n", "<leader>ch", function()
      vim.lsp.buf.hover()
      vim.lsp.buf.hover()
    end, opts)
    keymap("n", "<leader>cD", function() vim.lsp.buf.declaration() end, opts)
    keymap("n", "<leader>ci", function() vim.lsp.buf.implementation() end, opts)
    keymap("n", "<leader>co", function() vim.lsp.buf.type_definition() end, opts)
    keymap("n", "<leader>cr", function() vim.lsp.buf.references() end, opts)
    keymap("n", "<leader>cs", function() vim.lsp.buf.signature_help() end, opts)
    keymap("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
    -- keymap({ "n", "x", }, "<leader>cf", function() vim.lsp.buf.format({async = true}) end, opts)
    keymap("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    keymap("v", "<leader>ca", function() vim.lsp.buf.range_code_action() end, opts)

    -- Diagnostic
    keymap("n", "<leader>ce", function()
      vim.diagnostic.open_float()
      vim.diagnostic.open_float()
    end, opts)
    keymap("n", "<leader>cn", function() vim.diagnostic.jump({count = 1}) end, opts)
    keymap("n", "<leader>cN", function() vim.diagnostic.jump({count = -1}) end, opts)
  end
})
keymap({ "n", "x", }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true, })
end, remap)

-- Treesitter context (c)
keymap("n", "<leader>cc", ":TSContextToggle<CR>", remap)

-- Trouble (c)
keymap("n", "<leader>ct", [[:lua require("trouble").toggle("diagnostics")<CR>]], remap)

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
  if snip == nil then
    return
  end

  local end_node = snip.insert_nodes[0]

  while end_node and ls.jumpable(1) do
    current = session.current_nodes[vim.api.nvim_get_current_buf()]
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
keymap("n", "<leader>T",
  [[<cmd>lua require("toggleterm").toggle()<CR><cmd>setlocal number relativenumber<CR><cmd>:startinsert<CR>]], remap)

-- Open hex edit (H)
keymap("n", "<leader>H", [[:lua require("hex").toggle()<CR>]], remap)

-- Run (r)
keymap("n", "<leader>ro", [[:lua require("overseer").toggle()<CR>]], remap)
keymap("n", "<leader>rr", [[:w<CR>:lua require("overseer").run_template()<CR>]], remap)
keymap("n", "<leader>rl", [[:w<CR>:lua overseer_restart()<CR>]], remap)
keymap("n", "<leader>rt", [[:w<CR>:lua overseer_term()<CR>]], remap)
keymap("n", "<leader>rs", [[:w<CR>:lua overseer_stop()<CR>]], remap)

-- Nvim DAP (d)
keymap("n", "<leader>dc", function() require("dap").continue() end, remap)
keymap("n", "<leader>dn", function() require("dap").step_over() end, remap)
keymap("n", "<leader>dL", function() require("dap").step_into() end, remap)
keymap("n", "<leader>dH", function() require("dap").step_out() end, remap)
keymap("n", "<leader>db", function() require("dap").toggle_breakpoint() end, remap)
keymap("n", "<leader>dl", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, remap)
keymap("n", "<leader>dt", function() require("dap").repl.open() end, remap)
keymap("n", "<leader>dr", function() require("dap").run_last() end, remap)
keymap("n", "<leader>dt", function()
  require("dap").terminate()
  require("dapui").close()
end, remap)
keymap({ "n", "v" }, "<leader>dh", function() require("dap.ui.widgets").hover() end, remap)
keymap({ "n", "v" }, "<leader>dp", function() require("dap.ui.widgets").preview() end, remap)
keymap("n", "<leader>do", function() require("dapui").toggle() end, remap)

-- Others
keymap("n", "<leader>zc", function() require("colorizer").attach_to_buffer() end, remap)
