-- ~/.config/nvim/lua/plugins/colors.lua

return {
  -- https://github.com/loctvl842/monokai-pro.nvim
  {
    "loctvl842/monokai-pro.nvim",
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
      })

      -- Enable theme
      vim.cmd("colorscheme monokai-pro")

      -- Only highlight the line number not whole current line
      -- vim.cmd("highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE")
      -- vim.cmd("highlight NvimTreeCursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE")

      -- Windows line separator in white
      vim.cmd("highlight WinSeparator guifg=15")
      vim.cmd("highlight NvimTreeWinSeparator guifg=15")

      -- LspInfo floating window border color
      vim.cmd("highlight LspInfoBorder ctermfg=NONE ctermbg=NONE cterm=NONE")

      -- Waiting on https://github.com/loctvl842/monokai-pro.nvim/issues/75
      vim.cmd([[highlight RainbowDelimiterRed guifg=#fc618d ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterOrange guifg=#fd9353 ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterYellow guifg=#fce566 ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterGreen guifg=#7bd88f ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterCyan guifg=#5ad4e6 ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterViolet guifg=#948ae3 ctermfg=white]])

      -- indent-blankline, https://www.colorhexa.com, 70% 222222 + 30% <color theme>
      vim.cmd([[highlight IndentBlanklineIndent1 guifg=#633542 ctermfg=black gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guifg=#644431 ctermfg=black gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent3 guifg=#635d36 ctermfg=black gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent4 guifg=#3d5943 ctermfg=black gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent5 guifg=#33575d ctermfg=black gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent6 guifg=#44415c ctermfg=black gui=nocombine]])

      -- Invisible characters highlight
      vim.cmd([[highlight Whitespace cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#626064]])
      vim.cmd([[highlight! link IndentBlanklineSpaceChar Whitespace]])
      vim.cmd([[highlight! link NonText Whitespace]])

      -- Style for LuaSnip default placeholder text
      vim.api.nvim_set_hl(0, "LuaSnipPlace", {bg = "#363537", italic = true})

      -- TreeSitter highlights
      vim.api.nvim_set_hl(0, "@function.builtin.python", {link = "Function"})
    end,
  },

  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "│",
        show_end_of_line = true,
        show_trailing_blankline_indent = false,
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
        filetype_exclude = {
          "lspinfo",
          "packer",
          "checkhealth",
          "help",
          "man",
          "",
        },
      })
    end
  },

  -- https://github.com/hiphish/rainbow-delimiters.nvim
  {
    enabled = false, -- perfomance issue when typing (input delay)
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
          strategy = {
              [""] = rainbow_delimiters.strategy["global"],
          },
          query = {
              [""] = "rainbow-delimiters",
              lua = "rainbow-blocks",
              latex = "rainbow-delimiters",
          },
          highlight = {
              "RainbowDelimiterRed",
              "RainbowDelimiterOrange",
              "RainbowDelimiterYellow",
              "RainbowDelimiterGreen",
              "RainbowDelimiterCyan",
              "RainbowDelimiterViolet",
          },
      }
    end
  },

  -- https://github.com/NvChad/nvim-colorizer.lua
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
       require("colorizer").setup({
        filetypes = {"*"},
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          AARRGGBB = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
          tailwind = true,
          sass = {
            enable = true,
            parsers = {"css"},
          },
        },
      })
    end
  },

  -- https://github.com/tzachar/highlight-undo.nvim
  {
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    config = function()
      require("highlight-undo").setup({
        duration = 300,
      })

      vim.cmd([[hi! link HighlightUndo IncSearch]])
    end
  }
}
