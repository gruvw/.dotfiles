-- ~/.config/nvim/lua/gruvw/plugins/snippets.lua

return {
  {
    -- https://github.com/L3MON4D3/LuaSnip
    "L3MON4D3/LuaSnip",
    dependencies = {
      -- https://github.com/rafamadriz/friendly-snippets
      "rafamadriz/friendly-snippets",

      "nvim-treesitter",
    },
    build = "make install_jsregexp",
    event = "VeryLazy",
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")

      ls.setup({
        history = true,
        enable_autosnippets = true,
        update_events = { "TextChanged", "TextChangedI" },
        store_selection_keys = "<Tab>", -- use key on selection for $TM_SELECTED_TEXT content
        ext_opts = {
          [types.insertNode] = {
            unvisited = { hl_group = "LuaSnipPlace" },
          },
          [types.exitNode] = {
            unvisited = { hl_group = "LuaSnipPlace" },
          },
        }
      })

      -- Load user snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/gruvw/snippets/lua" })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/lua/gruvw/snippets/lsp" })

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load({
        exclude = { "plaintex", "tex" },
      })

      -- Filetype fixes
      ls.filetype_extend("plaintex", { "tex" })
      ls.filetype_extend("dart", { "flutter" })
      ls.filetype_extend("html", { "htmldjango" })
    end,
  },
}
