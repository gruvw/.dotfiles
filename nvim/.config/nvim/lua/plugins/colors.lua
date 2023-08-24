-- ~/.config/nvim/lua/plugins/colors.lua

return {
  -- https://github.com/loctvl842/monokai-pro.nvim
  {
    "loctvl842/monokai-pro.nvim",
    priority = 100,
    config = function()
      -- Setup and enable
      require("monokai-pro").setup({
        filter = "spectrum",
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
      vim.cmd("colorscheme monokai-pro")

      -- Only highlight the line number not whole current line
      vim.cmd("highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE")
      vim.cmd("highlight NvimTreeCursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE")

      -- Windows line separator in white
      vim.cmd("highlight WinSeparator guifg=15")
      vim.cmd("highlight NvimTreeWinSeparator guifg=15")

      -- LspInfo floating window border color
      vim.cmd("highlight LspInfoBorder ctermfg=NONE ctermbg=NONE cterm=NONE")
    end,
  },

  -- https://github.com/hiphish/rainbow-delimiters.nvim
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
          strategy = {
              [""] = rainbow_delimiters.strategy["global"],
              commonlisp = rainbow_delimiters.strategy["local"],
          },
          query = {
              [""] = "rainbow-delimiters",
              lua = "rainbow-blocks",
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

      -- Waiting on https://github.com/loctvl842/monokai-pro.nvim/issues/75
      vim.cmd([[highlight RainbowDelimiterRed guifg=#fc618d ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterOrange guifg=#fd9353 ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterYellow guifg=#fce566 ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterGreen guifg=#7bd88f ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterCyan guifg=#5ad4e6 ctermfg=white]])
      vim.cmd([[highlight RainbowDelimiterViolet guifg=#948ae3 ctermfg=white]])
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
}
