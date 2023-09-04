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

-- `\b(?<!\\)` regex is used to prevent expansion while writing a command (starts with `\`)

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

  s({
    name = "[G] Limits subscript",
    trig = [[-_]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[\limits_]]),
  }),

  -- Simple with one argument

  s({
    name = "[G] Verbatim",
    trig = [[\b(?<!\\)vrb]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\verb']]), si(1), t([[']]),
  }),

  s({
    name = "[G] Num",
    trig = [[\b(?<!\\)num]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\num{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Tilde",
    trig = [[\b(?<!\\)tld]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\widetilde{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Vector",
    trig = [[\b(?<!\\)vv]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\vv{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Bold vector",
    trig = [[\b(?<!\\)vb]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\mathbf{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Absolute value",
    trig = [[\b(?<!\\)abs]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\abs{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Norm",
    trig = [[\b(?<!\\)nrm]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\norm{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Overline",
    trig = [[\b(?<!\\)ovl]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\overline{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Square root",
    trig = [[\b(?<!\\)srt]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\sqrt{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Math rm",
    trig = [[\b(?<!\\)mrm]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\mathrm{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Set",
    trig = [[\b(?<!\\)sst]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\{ ]]), si(1), t([[ \}]]),
  }),

  s({
    name = "[G] Angles",
    trig = [[\b(?<!\\)ang]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\langle ]]), si(1), t([[\rangle]]),
  }),

  s({
    name = "[G] Supperscript",
    trig = [[--]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[^{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Subscript",
    trig = [[__]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[_{]]), si(1), t([[}]]),
  }),

  s({
    name = "[G] Big cap single",
    trig = [[\b(?<!\\)bca]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\bigcap_{]]), i(1, [[i]]), t([[} ]]),
  }),

  s({
    name = "[G] Big cup single",
    trig = [[\b(?<!\\)bcu]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\bigcup_{]]), i(1, [[i]]), t([[} ]]),
  }),

  s({
    name = "[G] Product single",
    trig = [[\b(?<!\\)ppr]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\prod_{]]), i(1, [[i]]), t([[} ]]),
  }),

  s({
    name = "[G] Sum single",
    trig = [[\b(?<!\\)ssm]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\sum_{]]), i(1, [[i]]), t([[} ]])
  }),


  -- Simple with multiple arguments

  s({
    name = "[G] Partial derivative",
    trig = [[\b(?<!\\)part]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\frac{\partial ]]), si(1), t([[}{\partial ]]), i(2), t([[}]]),
  }),

  s({
    name = "[G] Fraction",
    trig = [[\b(?<!\\)ff]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\frac{]]), si(1), t([[}{]]), i(2), t([[}]]),
  }),

  s({
    name = "[G] Binomial",
    trig = [[\b(?<!\\)bnm]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\binom{]]), i(1, [[n]]), t([[}{]]), i(2, [[k]]), t([[}]]),
  }),

  s({
    name = "[G] Integral definite",
    trig = [[\b(?<!\\)dint]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\int_{]]), i(1, [[-\infty]]), t([[}^{]]), i(2, [[\infty]]), t([[} ]]),
  }),

  s({
    name = "[G] Sum",
    trig = [[\b(?<!\\)Ssm]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\sum_{]]), i(1, [[i]]), t([[=]]), i(2, [[1]]), t([[}^{]]), i(3, [[\infty]]), t([[} ]]),
  }),

  s({
    name = "[G] Product",
    trig = [[\b(?<!\\)Ppr]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\prod{]]), i(1, [[i]]), t([[=]]), i(2, [[1]]), t([[}^{]]), i(3, [[n]]), t([[} ]]),
  }),

  s({
    name = "[G] Big cup",
    trig = [[\b(?<!\\)Bcu]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\bigcup_{]]), i(1, [[i]]), t([[=]]), i(2, [[1]]), t([[}^{]]), i(3, [[\infty]]), t([[} ]]),
  }),

  s({
    name = "[G] Big cap",
    trig = [[\b(?<!\\)Bca]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\bigcap_{]]), i(1, [[i]]), t([[=]]), i(2, [[1]]), t([[}^{]]), i(3, [[\infty]]), t([[} ]]),
  }),

  s({
    name = "[G] Inline limit",
    trig = [[\b(?<!\\)lim]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\lim_{]]), i(1, [[x]]), t([[ \to ]]), i(2, [[\infty]]), t([[} ]]),
  }),

  s({
    name = "[G] Limit",
    trig = [[\b(?<!\\)Lim]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\lim\limits_{]]), i(1, [[x]]), t([[ \to ]]), i(2, [[\infty]]), t([[} ]]),
  }),

  s({
    name = "[G] Arrow limit",
    trig = [[\b(?<!\\)alim]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\xrightarrow[]]), i(1, [[x]]), t([[ \to ]]), i(2, [[\infty]]), t([[]{]]), i(3), t([[} ]]),
  }),

  -- Simple trigger match interpolation

  s({
    name = "[G] Differential",
    trig = [[\b(?<!\\)dd(\w)]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\,d]]), rg(1),
  }),

  s({
    name = "[G] _{n-d}",
    trig = [[_?(\w)m(\d)]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[_{]]), rg(1), t([[-]]), rg(2), t([[}]]),
  }),


  s({
    name = "[G] _{n+d}",
    trig = [[(?!M)_?(\w)p(\d)]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[_{]]), rg(1), t([[+]]), rg(2), t([[}]]),
  }),

  s({
    name = "[G] Arc-trigo",
    trig = [[\b(?<!\\)a(sin|cos|tan)]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\arc]]), rg(1), t([[ ]]),
  }),

  s({
    name = "[G] Commands without space",
    trig = [[\b(?<!\\)(?<!\\mathrm\{)(max|min|log)]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\]]), rg(1),
  }),

  s({
    name = "[G] Commands with space",
    trig = [[\b(?<!\\)(?<!\\mathrm\{)(ker|det|deg|sin|cos|tan|cot|ln|exp|arg|to|perp|in|cup|cap|ge|le|sim|pm|iff|mid|dim|Im|Re|not|vee)]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\]]), rg(1), t([[ ]]),
  }),

  s({
    name = "[G] Special commands (mathrm)",
    trig = [[\b(?<!\\)(?<!\\mathrm\{)(Vect|rg|var|cov|corr)]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\mathrm{]]), rg(1), t([[}]]),
  }),


  -- Trigger match interpolation transformed



  -- Arguments with trigger match interpolation

  s({
    name = "[G] Commands with argument (mathrm)",
    trig = [[\b(?<!\\)(?<!\\mathrm\{)(bar|dot|hat)]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\]]), rg(1), t([[{]]), i(1), t([[}]]),
  }),

  -- Automatic

  s({
    name = "[G] Auto subscript",
    trig = [[(\B\\[A-Za-z]+|\b\d*[A-Za-z])(\d)]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    rg(1), t([[_]]), rg(2),
  }),

  s({
    name = "[G] Auto subscript 2",
    trig = [[_([A-Za-z\d]{2})]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[_{]]), rg(1), t([[}]]),
  }),

  s({
    name = "[G] Auto subscript after }",
    trig = [[\}(\d)]],
    trigEngine = "ecma",
    wordTrig = false,
    condition = in_mathzone,
  }, {
    t([[}_]]), rg(1),
  }),

  s({
    name = "[G] Square root auto",
    trig = [[\((((?:\([^()]*\)|[^()])*))\)rt]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\sqrt{]]), rg(1), t([[}]]),
  }),

  -- Postfix modifications

  s({
    name = "[G] Fraction automatic",
    trig = [[((\d+)|(\d*)(\\)?([A-Za-z]+)((\^|_)(\{\w+\}|\w))*)\/$|(\(((?:\([^()]*\)|[^()])*)\))\/$]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\frac{]]),
    f(function(_, snip)
      return snip.captures[1] .. snip.captures[10]
    end),
    t([[}{]]),
    i(1),
    t([[}]]),
  }),

  s({
    name = "[G] Mathbb",
    trig = [[([A-Z])#]],
    trigEngine = "ecma",
    condition = in_mathzone,
  }, {
    t([[\mathbb{]]), rg(1), t([[}]]),
  }),

  -- Complex code interpolated


}
