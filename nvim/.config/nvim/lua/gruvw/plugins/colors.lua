-- ~/.config/nvim/lua/plugins/colors.lua

local hl = vim.api.nvim_set_hl

return {
  -- https://github.com/loctvl842/monokai-pro.nvim
  {
    "loctvl842/monokai-pro.nvim",
    enabled = false,
    priority = 51,
    config = function()
      local colors = require("monokai-pro.colorscheme.palette.spectrum")
      local base = {
        none = "none",
        bg = "#222222",
        dark = colors.dark2,
        black = colors.dark1,
        red = colors.accent1,
        green = colors.accent4,
        yellow = colors.accent3,
        orange = colors.accent2,
        magenta = colors.accent6,
        cyan = colors.accent5,
        white = colors.text,
        dimmed1 = colors.dimmed1,
        dimmed2 = colors.dimmed2,
        dimmed3 = colors.dimmed3,
        dimmed4 = colors.dimmed4,
        dimmed5 = colors.dimmed5,
      }

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
            Structure = { fg = base.cyan, italic = false, },
            Macro = { fg = base.cyan, italic = true, },
            SpellBad = { fg = base.cyan, italic = true, underline = true, undercurl = false, sp = base.cyan, },
            SpellRare = { link = "SpellBad", },
            SpellLocal = { link = "SpellBad", },

            -- Treesitter
            ["@keyword"] = { fg = base.red, italic = false, },
            ["@type"] = { fg = base.cyan, },
            -- ["@property"] = { fg = base.white, },
            ["@parameter"] = { fg = base.orange, },

            -- Semantic tokens
            ["@lsp.mod.interpolation"] = { fg = base.orange, },
            ["@lsp.type.annotation"] = { fg = base.cyan, italic = true, },
            ["@lsp.type.parameter"] = { link = "@parameter", },
            ["@lsp.typemod.class.defaultLibrary"] = { fg = base.cyan, },
            ["@lsp.typemod.property.annotation"] = { fg = base.cyan, italic = true, },
            ["@lsp.typemod.function.defaultLibrary"] = { fg = base.green, },
            ["@lsp.typemod.parameter.declaration"] = { link = "@parameter", },
            ["@lsp.typemod.variable.readonly"] = { fg = base.white, },
            ["@lsp.type.keyword.typst"] = { link = "@keyword" },

            -- Language specific
            ["@property"] = { fg = base.red, },
            ["@lsp.type.class.dart"] = { fg = base.cyan, italic = false, },
            ["@type.python"] = { fg = base.cyan, },
            ["@keyword.python"] = { link = "@keyword", },
            ["@text.literal.markdown_inline"] = { fg = base.orange, italic = true, bg = base.none, },
            ["@markup.raw.markdown_inline"] = { fg = base.orange, italic = true, bg = base.none, },
            ["@markup.raw.block.markdown"] = { bg = base.none, },
            ["@markup.heading"] = { fg = base.yellow, bold = true, },
            ["@markup.heading.1.markdown"] = { bold = true },
            ["@markup.heading.2.markdown"] = { bold = true },
            ["@markup.heading.3.markdown"] = { bold = true },
            ["@none.markdown"] = { bg = base.none, },
            ["@conceal.markdown"] = { bg = base.none, },
            ["@lsp.type.pol.typst"] = { link = "@parameter" },
            ["@lsp.type.string.typst"] = { link = "String" },
            ["@lsp.type.operator.typst"] = { link = "Operator" },
            ["@lsp.type.punct.typst"] = { link = "@punctuation.bracket" },
            ["@lsp.type.heading.typst"] = { link = "@text.title.1.markdown" },
            ["@lsp.mod.strong.typst"] = { link = "@text.strong.markdown_inline" },
            ["@lsp.type.marker.typst"] = { link = "@punctuation.special.markdown" },

            -- Plugins
            ["OilDir"] = { bg = base.none, fg = base.green, bold = true, },
            ["OilFile"] = { bg = base.none, fg = base.white, },
            ["OilSize"] = { bg = base.none, fg = base.white, italic = true, },
          }
        end,
      })

      -- Enable theme
      vim.cmd("colorscheme monokai-pro")

      -- Only highlight the line number not whole current line
      -- hl(0, "CursorLine", { bg = "none", })
      -- hl(0, "NvimTreeCursorLine", { bg = "none", })

      -- Windows line separator in white
      hl(0, "WinSeparator", { fg = "white", })
      hl(0, "NvimTreeWinSeparator", { fg = "white", })
      hl(0, "FloatBorder", { fg = "white", })

      -- LspInfo floating window border color
      hl(0, "LspInfoBorder", { fg = "white", })

      -- NvimTree
      hl(0, "NvimTreeNormalFloat", { fg = "white", })
      hl(0, "NvimTreeFolderName", { fg = "white", })
      hl(0, "NvimTreeOpenedFolderName", { fg = "white", italic = true, })

      -- Leap
      hl(0, "LeapLabelPrimary", { link = "IncSearch", })
      hl(0, "LeapLabelSecondary", { fg = "#222222", bg = "#fd9353", bold = true, })

      -- Telescope
      hl(0, "TelescopeMatching", { link = "IncSearch", })
      hl(0, "TelescopeSelectionCaret", { bg = "#363537", fg = "#7bd88f", bold = true, })
      hl(0, "TelescopeResultsBorder", { fg = "white", })
      hl(0, "TelescopePromptBorder", { fg = "white", })
      hl(0, "TelescopePreviewBorder", { fg = "white", })
      hl(0, "TelescopePromptNormal", { fg = "white", })
      hl(0, "TelescopePromptPrefix", { fg = "#7bd88f", })
      hl(0, "TelescopeResultsNormal", { fg = "white", })


      -- Invisible characters highlight
      hl(0, "Whitespace", { fg = "#626064", })
      hl(0, "IndentBlanklineSpaceChar", { link = "Whitespace", })
      hl(0, "NonText", { link = "Whitespace", })

      -- Match paren
      hl(0, "MatchParen", { fg = "#fce566", underline = false, bold = true, })

      -- Style for LuaSnip default placeholder text
      hl(0, "LuaSnipPlace", { bg = "#363537", italic = true, })

      -- TreeSitter highlights
      hl(0, "@function.builtin.python", { link = "Function", })
    end,
  },

  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    priority = 51,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        on_colors = function(colors)
          colors.bg = "#222222"
          -- TODO apply custom colors
        end,
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },



  -- https://github.com/tzachar/highlight-undo.nvim
  {
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    config = function()
      require("highlight-undo").setup({
        duration = 300,
      })

      hl(0, "HighlightUndo", { link = "IncSearch", })
      hl(0, "HighlightRedo", { link = "IncSearch", })
    end
  },

  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "plenary.nvim",
      "telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup({
        signs = false,
        merge_keywords = false,
        colors = {},
        highlight = {
          multiline = false,
          before = "",
          keyword = "bg",
          after = "fg",
          pattern = [[\s*<(KEYWORDS)\s*:?]],
          comments_only = true,
          exclude = {}, -- list of filetypes to exclude highlighting
        },
        keywords = {
          TODO = {
            icon = "T",
            color = "#fc618d",
            alt = { "todo", },
          },
          FIX = {
            icon = "F",
            color = "#fce566",
            alt = { "FIXME", "FIXIT", "ISSUE", "CHANGE", },
          },
          BUG = {
            icon = "B",
            color = "#5ad4e6",
          },
          ASK = {
            icon = "A",
            color = "#5ad4e6",
          },
          PAUSED = {
            icon = "P",
            color = "#fd9353",
            alt = { "PAUSE", "LEFT", "LEFT HERE", "PAUSED HERE", }
          },
          WARN = {
            icon = "W",
            color = "#fd9353",
            alt = { "WARNING", "XXX", },
          },
          NOTE = {
            icon = "N",
            color = "#787878",
            alt = { "INFO", },
          },
        },
        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS)\s*:?]],
        },
      })
    end
  }
}
