-- ~/.config/nvim/lua/plugins/components.lua

-- Lualine components

-- Vim mode
local mode_map = {
  ["NORMAL"] = "N",
  ["O-PENDING"] = "OP",
  ["INSERT"] = "I",
  ["VISUAL"] = "V",
  ["V-BLOCK"] = "VB",
  ["V-LINE"] = "VL",
  ["V-REPLACE"] = "VR",
  ["REPLACE"] = "R",
  ["COMMAND"] = "C",
  ["SHELL"] = "SH",
  ["TERMINAL"] = "T",
  ["EX"] = "X",
  ["S-BLOCK"] = "SB",
  ["S-LINE"] = "SL",
  ["SELECT"] = "S",
  ["CONFIRM"] = "Y?",
  ["MORE"] = "M",
}
local mode_cmpnt = {
  "mode",
  fmt = function(s)
    return mode_map[s] or s
  end,
}

-- File type
local filetype_cmpnt = {
  "filetype",
  icon_only = true,
  icon = {align = "right"},
}

-- File name
local filename_cmpnt = {
  "filename",
  symbols = {
    modified = "+",
    readonly = "-",
    unnamed = "[No Name]",
    newfile = "[New]",
  }
}

-- Progress rename strings
local progress_map = {
  ["Top"] = "top",
  ["Bot"] = "btm",
}
local progress_cmpnt = {
  "progress",
  fmt = function(s)
    return progress_map[s] or s
  end,
}

-- Nvim-tree
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5


return {
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      -- https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons", -- icons support
    },
    -- event = "VeryLazy",
    opts = {
      options = {
        theme = "monokai-pro",
        globalstatus = true,
        icons_enabled = true,
        section_separators = {left = "", right = ""},
        component_separators = {left = "|", right = "|"},
        refresh = {
          statusline = 500,
          tabline = 500,
          winbar = 500,
        }
      },
      sections = {
        lualine_a = {mode_cmpnt},
        lualine_b = {"branch", "diff", "diagnostics"},
        lualine_c = {filename_cmpnt, "encoding"},
        lualine_x = {filetype_cmpnt},
        lualine_y = {progress_cmpnt},
        lualine_z = {"location"},
      },
    },
  },

  -- https://github.com/nvim-tree/nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      -- https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons", -- icons support
    },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          relativenumber = true,
          number = true,
          -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#center-a-floating-nvim-tree-window
          float = {
            enable = true,
            open_win_config = function()

              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2)
                              - vim.opt.cmdheight:get()
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
              end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
        },
      })
    end,
  },

  -- https://github.com/gelguy/wilder.nvim
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    build = ":UpdateRemotePlugins",
    config = function()
      local wilder = require("wilder")

      wilder.setup({
        modes = {":", "/", "?"},
      })

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline(),
          wilder.vim_search_pipeline()
        ),
      })

      wilder.set_option("renderer", wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          highlighter = wilder.basic_highlighter(),
          highlights = {
          accent = wilder.make_hl("WilderAccent", "Pmenu", {{a = 1}, {a = 1}, {foreground = "#7bd88f"}}),
            border = "Normal",
          },
          border = "rounded",
          reverse = 1,
          max_height = "25%",
        })
      ))

    end
  },
}
