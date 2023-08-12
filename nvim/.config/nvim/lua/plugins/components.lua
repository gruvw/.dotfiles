
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


return {
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      -- https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons", -- icons support
    },
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
}
