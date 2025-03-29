-- ~/.config/nvim/lua/gruvw/plugins/theme.lua

local colors = {
  none = "none",
  bg = "#222222",
  bg_light = "#363537",
  black = "#191919",
  white = "#f7f1ff",
  red = "#fc618d",
  green = "#7bd88f",
  yellow = "#fce566",
  orange = "#fd9353",
  magenta = "#948ae3",
  cyan = "#5ad4e6",
  comment = "#8b888f",
}

local function custom_highlight()
  local hl = vim.api.nvim_set_hl

  -- Only highlight the line number not whole current line
  -- hl(0, "CursorLine", { bg = "none", })
  -- hl(0, "NvimTreeCursorLine", { bg = "none", })

  -- Windows line separator in white
  hl(0, "WinSeparator", { fg = colors.white, })
  hl(0, "NvimTreeWinSeparator", { fg = colors.white, })
  hl(0, "FloatBorder", { fg = colors.white, })

  -- hl(0, "@string", { fg = colors.yellow, })

  -- LspInfo floating window border color
  hl(0, "LspInfoBorder", { fg = colors.white, })

  -- NvimTree
  hl(0, "NvimTreeNormalFloat", { fg = colors.white, })
  hl(0, "NvimTreeFolderName", { fg = colors.white, })
  hl(0, "NvimTreeOpenedFolderName", { fg = colors.white, italic = true, })

  -- Leap
  hl(0, "LeapLabelPrimary", { link = "IncSearch", })
  hl(0, "LeapLabelSecondary", { fg = colors.bg, bg = colors.orange, bold = true, })

  -- Telescope
  hl(0, "TelescopeMatching", { link = "IncSearch", })
  hl(0, "TelescopeSelectionCaret", { bg = colors.bg_light, fg = colors.green, bold = true, })
  hl(0, "TelescopeResultsBorder", { fg = colors.white, })
  hl(0, "TelescopePromptBorder", { fg = colors.white, })
  hl(0, "TelescopePreviewBorder", { fg = colors.white, })
  hl(0, "TelescopePromptNormal", { fg = colors.white, })
  hl(0, "TelescopeResultsNormal", { fg = colors.white, })
  hl(0, "TelescopePromptPrefix", { fg = colors.green, })

  -- Invisible characters highlight
  hl(0, "Whitespace", { fg = "#626064", })
  hl(0, "IndentBlanklineSpaceChar", { link = "Whitespace", })
  hl(0, "NonText", { link = "Whitespace", })

  -- Match paren
  hl(0, "MatchParen", { fg = colors.yellow, underline = false, bold = true, })

  -- Style for LuaSnip default placeholder text
  hl(0, "LuaSnipPlace", { bg = colors.bg_light, italic = true, })

  -- TreeSitter highlights
  hl(0, "@function.builtin.python", { link = "Function", })

  -- indent-blankline.nvim, https://www.colorhexa.com, 70% 222222 + 30% <color theme>
  hl(0, "IndentBlanklineIndent1", { fg = "#633542", nocombine = true, })
  hl(0, "IndentBlanklineIndent2", { fg = "#644431", nocombine = true, })
  hl(0, "IndentBlanklineIndent3", { fg = "#635d36", nocombine = true, })
  hl(0, "IndentBlanklineIndent4", { fg = "#3d5943", nocombine = true, })
  hl(0, "IndentBlanklineIndent5", { fg = "#33575d", nocombine = true, })
  hl(0, "IndentBlanklineIndent6", { fg = "#44415c", nocombine = true, })

  -- highlight-under.nvim
  hl(0, "HighlightUndo", { link = "IncSearch", })
  hl(0, "HighlightRedo", { link = "IncSearch", })
end

return {
  {
    "chromance.nvim",
    dev = true,
    priority = 101,
    enabled = false, -- TODO use only chromance
    config = function()
      require("chromance").setup()

      vim.cmd("colorscheme chromance")

      custom_highlight()
    end
  },
  {
    -- https://github.com/loctvl842/monokai-pro.nvim
    "loctvl842/monokai-pro.nvim",
    priority = 101,
    -- enabled = false,
    config = function()
      require("monokai-pro").setup({
        filter = "spectrum",
        devicons = true,
        background_clear = {
          "float_win",
          "toggleterm",
          "telescope",
          "which-key",
          "renamer",
          "notify",
          "nvim-tree",
          "neo-tree",
        },
        override = function()
          -- https://github.com/loctvl842/monokai-pro.nvim/issues/79
          return {
            Structure = { fg = colors.cyan, italic = false, },
            Macro = { fg = colors.cyan, italic = true, },
            SpellBad = { fg = colors.cyan, italic = true, underline = true, undercurl = false, sp = colors.cyan, },
            SpellRare = { link = "SpellBad", },
            SpellLocal = { link = "SpellBad", },

            -- Treesitter
            ["@keyword"] = { fg = colors.red, italic = false, },
            ["@type"] = { fg = colors.cyan, },
            -- ["@property"] = { fg = colors.white, },
            ["@parameter"] = { fg = colors.orange, },

            -- Semantic tokens
            ["@lsp.mod.interpolation"] = { fg = colors.orange, },
            ["@lsp.type.annotation"] = { fg = colors.cyan, italic = true, },
            ["@lsp.type.parameter"] = { link = "@parameter", },
            ["@lsp.typemod.class.defaultLibrary"] = { fg = colors.cyan, },
            ["@lsp.typemod.property.annotation"] = { fg = colors.cyan, italic = true, },
            ["@lsp.typemod.function.defaultLibrary"] = { fg = colors.green, },
            ["@lsp.typemod.parameter.declaration"] = { link = "@parameter", },
            ["@lsp.typemod.variable.readonly"] = { fg = colors.white, },
            ["@lsp.type.keyword.typst"] = { link = "@keyword" },

            -- Language specific
            ["@property"] = { fg = colors.red, },
            ["@lsp.type.class.dart"] = { fg = colors.cyan, italic = false, },
            ["@type.python"] = { fg = colors.cyan, },
            ["@keyword.python"] = { link = "@keyword", },
            ["@text.literal.markdown_inline"] = { fg = colors.orange, italic = true, bg = colors.none, },
            ["@markup.raw.markdown_inline"] = { fg = colors.orange, italic = true, bg = colors.none, },
            ["@markup.raw.block.markdown"] = { bg = colors.none, },
            ["@markup.heading"] = { fg = colors.yellow, bold = true, },
            ["@markup.heading.1.markdown"] = { bold = true },
            ["@markup.heading.2.markdown"] = { bold = true },
            ["@markup.heading.3.markdown"] = { bold = true },
            ["@none.markdown"] = { bg = colors.none, },
            ["@conceal.markdown"] = { bg = colors.none, },
            ["@lsp.type.pol.typst"] = { link = "@parameter" },
            ["@lsp.type.string.typst"] = { link = "String" },
            ["@lsp.type.operator.typst"] = { link = "Operator" },
            ["@lsp.type.punct.typst"] = { link = "@punctuation.bracket" },
            ["@lsp.type.heading.typst"] = { link = "@text.title.1.markdown" },
            ["@lsp.mod.strong.typst"] = { link = "@text.strong.markdown_inline" },
            ["@lsp.type.marker.typst"] = { link = "@punctuation.special.markdown" },

            -- Plugins
            ["OilDir"] = { bg = colors.none, fg = colors.green, bold = true, },
            ["OilFile"] = { bg = colors.none, fg = colors.white, },
            ["OilSize"] = { bg = colors.none, fg = colors.white, italic = true, },
          }
        end,
      })

      -- Enable theme
      vim.cmd("colorscheme monokai-pro")

      custom_highlight()
    end,
  },
}
