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

      -- https://github.com/notjedi/nvim-rooter.lua
      "notjedi/nvim-rooter.lua",
    },
    config = function()
      -- Set keybinds
      local function tree_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return {desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
        end

        vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open Vertical Split"))
        vim.keymap.set("n", "<C-h>", api.node.open.horizontal, opts("Open Horizontal Split"))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Parent Directory"))
        vim.keymap.set("n", "H", api.node.navigate.parent, opts("Navigate to Parent Directory"))
        vim.keymap.set("n", "R", api.tree.change_root_to_node, opts("Change Root to Node"))
        vim.keymap.set("n", "K", api.node.show_info_popup, opts("Show Info PopUp"))
        vim.keymap.set("n", "o", api.fs.create, opts("Create"))
        vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy"))
        vim.keymap.set("n", "yw", api.fs.copy.filename, opts("Copy Name"))
        vim.keymap.set("n", "yp", api.fs.copy.relative_path, opts("Copy Relative Path"))
        vim.keymap.set("n", "yP", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
        vim.keymap.set("n", "d", api.fs.cut, opts("Cut"))
        vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
        vim.keymap.set("n", "C", api.tree.collapse_all, opts("Collapse All"))
        vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
        vim.keymap.set("n", "/", api.tree.search_node, opts("Search"))
        vim.keymap.set("n", "v", api.node.run.system, opts("Run System Explorer"))
        vim.keymap.set("n", "cw", api.fs.rename, opts("Rename"))
        vim.keymap.set("n", "r", api.fs.rename_basename, opts("Rename Base Name"))
        vim.keymap.set("n", "P", api.node.navigate.parent, opts("Jump to Parent"))
        vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
        vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Show Help"))
        vim.keymap.set("n", "F", api.live_filter.clear, opts("Clear Filter"))
      end

      require("nvim-tree").setup({
        on_attach = tree_on_attach,
        update_cwd = true,
        disable_netrw = true,
        hijack_netrw = true,
        update_focused_file = {
          enable = true,
          update_cwd = true
        },
        system_open = {
          cmd = "kitty",
          args = {"vifm"},
        },
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
                border = "single",
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
        actions = {
          file_popup = {
            open_win_config = {
              border = "single",
            },
          },
        }
      })

      require("nvim-rooter").setup({
        rooter_patterns = {".git", ".hg", ".svn"},
        trigger_patterns = {"*"},
        manual = false,
        fallback_to_parent = true,
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
          border = "single",
          reverse = 1,
          max_height = "25%",
        })
      ))
    end
  },
}
