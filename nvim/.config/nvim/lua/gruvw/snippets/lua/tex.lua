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

return
{

},
-- Automatic
{

  -- Quick fix

  s({
    name = "[G] Square",
    trig = [[ ?sq]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[^2]]),
  }),
  s({
    name = "[G] Cube",
    trig = [[ ?cb]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[^3]]),
  }),

  -- No argument commands (space after)

  s({
    name = "[G] Rightarrow",
    trig = [[\b(?<!\\)Rra]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\Rightarrow ]]),
  }),

  s({
    name = "[G] Wedge (AND)",
    trig = [[\b(?<!\\)wdg]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\wedge ]]),
  }),

  s({
    name = "[G] Proportional",
    trig = [[\b(?<!\\)prp]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\propto ]]),
  }),

  s({
    name = "[G] Equiv",
    trig = [[\b(?<!\\)eqv]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\equiv ]]),
  }),

  s({
    name = "[G] Partial",
    trig = [[\b(?<!\\)prt]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\partial ]]),
  }),

  s({
    name = "[G] Integral",
    trig = [[\b(?<!\\)nnt]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\int ]]),
  }),

  s({
    name = "[G] Surface integral",
    trig = [[\b(?<!\\)ont]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\oint ]]),
  }),

  s({
    name = "[G] Circle",
    trig = [[\b(?<!\\)cir]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\circ ]]),
  }),

  s({
    name = "[G] Not equal",
    trig = [[\b(?<!\\)ne]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\neq ]]),
  }),

  s({
    name = "[G] Subset",
    trig = [[\b(?<!\\)sub]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\subset ]]),
  }),

  s({
    name = "[G] Supset",
    trig = [[\b(?<!\\)sup]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\supset ]]),
  }),

  s({
    name = "[G] Subseteq",
    trig = [[\b(?<!\\)sue]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\subseteq ]]),
  }),

  s({
    name = "[G] Gradient",
    trig = [[\b(?<!\\)grd]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\nabla ]]),
  }),

  s({
    name = "[G] Allow Break",
    trig = [[\b(?<!\\)awb]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\allowbreak ]]),
  }),

  s({
    name = "[G] Quad",
    trig = [[\b(?<!\\)qq]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\quad ]]),
  }),

  s({
    name = "[G] Leftrightarrow",
    trig = [[\b(?<!\\)Lra]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\Leftrightarrow ]]),
  }),

  s({
    name = "[G] leftrightarrow",
    trig = [[\b(?<!\\)lra]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\leftrightarrow ]]),
  }),

  s({
    name = "[G] Ldots",
    trig = "..",
    condition = in_mathzone,
  }, {
    t([[\ldots ]]),
  }),

  s({
    name = "[G] Implies",
    trig = [[\b(?<!\\)imm]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\implies ]]),
  }),

  s({
    name = "[G] Implied by",
    trig = [[\b(?<!\\)iib]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\impliedby ]]),
  }),

  s({
    name = "[G] Almost equal",
    trig = [[\b(?<!\\)app]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\approx ]]),
  }),

  s({
    name = "[G] Mapsto",
    trig = [[\b(?<!\\)mto]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\mapsto ]]),
  }),

  s({
    name = "[G] Exists",
    trig = [[\b(?<!\\)ee]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\exists ]]),
  }),

  s({
    name = "[G] For all",
    trig = [[\b(?<!\\)fa]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\forall ]]),
  }),

  s({
    name = "[G] Cross",
    trig = [[\b(?<!\\)xx]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\times ]]),
  }),

  s({
    name = "[G] cdot",
    trig = [[\b(?<!\\)cd]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\cdot ]]),
  }),

  s({
    name = "[G] Setminus",
    trig = [[\b(?<!\\)stm]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\setminus ]]),
  }),

  s({
    name = "[G] Displaystyle",
    trig = [[\b(?<!\\)dsp]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\displaystyle ]]),
  }),

  -- No argument commands (no space after)

  s({
    name = "[G] Infinity",
    trig = [[\b(?<!\\)iin]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\infty]]),
  }),

  s({
    name = "[G] Empty Set",
    trig = [[\b(?<!\\)emp]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\emptyset]]),
  }),

  s({
    name = "[G] Null set",
    trig = [[\b(?<!\\)0n]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\varnothing]]),
  }),

  -- Simple with arguments

  s({
    name = "[G] Verbatim",
    trig = [[\b(?<!\\)vrb]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\verb']]), i(1), t([[']]),
  }),

  s({
    name = "[G] Num",
    trig = [[\b(?<!\\)num]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\num{]]), i(1), t([[}]]),
  }),

  s({
    name = "[G] Tilde",
    trig = [[\b(?<!\\)tld]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\widetilde{]]), i(1), t([[}]]),
  }),

}
