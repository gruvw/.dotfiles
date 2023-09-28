-- ~/.config/nvim/lua/gruvw/snippets/lua/markdown.lua

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

return
{
  -- Paste image
  s({
    name = "[G] Paste image",
    trig = "pimg",
    docstring = [[\includegraphics[width=${1:8cm}]{${2:img_name}}]], -- disable calling function during snippet preview
  }, {
    d(1, function()
      local cwd = vim.fn.getcwd()
      local input = vim.fn.input("Image name: ")
      local default = "image_" .. math.random(1, 9999)
      local img_name = (input ~= nil and input ~= "" and input or default) .. ".png"
      local img_path = cwd .. "/markdown-img/" .. img_name
      local cmd = "\"!xclip -selection clipboard -t image/png -o > " .. img_path .. "\""

      -- Create latex-img if not present
      vim.cmd([[silent exec "!mkdir markdown-img"]])

      -- Paste image from clipboard
      vim.cmd([[silent exec ]] .. cmd)

      return sn(nil, { t([[![]]), i(1, input), t([[](./markdown-img/]] .. img_name .. [[)]]), })
    end),
  }),

},
-- Automatic
{
}
