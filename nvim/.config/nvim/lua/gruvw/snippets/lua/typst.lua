-- ~/.config/nvim/lua/gruvw/snippets/lua/tex.lua

--- @diagnostic disable: unused-local
--- @diagnostic disable: unused-function

local ts = require("vim.treesitter")
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

-- Regex match group content helper, groups start at 0
local rg = function(group_nb)
  return f(function(_, snip)
    return snip.captures[group_nb]
  end)
end

-- Insert node with selected text placeholder helper
local si = function(nb)
  return d(nb, function(_, parent)
    return sn(nil, i(1, parent.snippet.env.TM_SELECTED_TEXT))
  end)
end

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}

local COMMENT = {
  comment = true,
  line_comment = true,
  block_comment = true,
  comment_environment = true,
}

local function get_node_at_cursor()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  col = col - 1

  local ok, parser = pcall(ts.get_parser, buf, "latex")
  if not ok or not parser then return end

  local root_tree = parser:parse()[1]
  local root = root_tree and root_tree:root()

  if not root then
    return
  end

  return root:named_descendant_for_range(row, col, row, col)
end

local function in_comment()
  local node = get_node_at_cursor()
  while node do
    if COMMENT[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

local function in_mathzone()
  local node = get_node_at_cursor()
  while node do
    if node:type() == "text_mode" then
      return false
    elseif MATH_NODES[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

-- `\b(?<!#)` regex is used to prevent expansion while writing a command (starts with `#`)

return
{
  -- Paste image
  s({
    name = "[G] Paste image",
    trig = "pimg",
    docstring = "Paste image under cursor",
  }, {
    d(1, function()
      local IMG_DIR = "images"

      local input = vim.fn.input("Image name: ")
      local default = "image_" .. os.time()
      local img_name = (input ~= nil and input ~= "" and input or default) .. ".png"

      local rel_path = IMG_DIR .. "/" .. img_name

      -- Create images directory if not present
      vim.cmd([[silent exec "!mkdir ]] .. IMG_DIR .. [["]])

      local cwd = vim.fn.getcwd()
      local img_path = cwd .. "/" .. rel_path
      local cmd = "!xclip -selection clipboard -t image/png -o > " .. img_path

      -- Paste image from clipboard
      vim.cmd([[silent exec "]] .. cmd .. [["]])

      return sn(nil, { t([[#image("]] .. rel_path .. [[", width: ]]), i(1, "100"), t([[%)]]), })
    end),
  }),
},
-- Automatic
{
  s({
    name = "[G] New item",
    trig = "kk",
  }, {
    t({"#cb["}), i(1), t("]: "), si(2),
  }),
}
