-- ~/.config/nvim/lua/plugins/components.lua

-- Nvim-tree
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
  -- https://github.com/nvim-tree/nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      -- https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons", -- icons support

    },
    priority = 51,
    config = function()
      -- Set keybinds
      local function tree_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true, }
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
        -- vim.keymap.set({ "v", "n" }, "D", api.fs.trash, opts("Trash"))
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
        vim.keymap.set("n", "<leader><CR>", function(node, ...)
          node = node or require("nvim-tree.lib").get_node_at_cursor()
          system_open(node.absolute_path)
          api.tree.close()
        end, opts("Open in native app"))
      end

      require("nvim-tree").setup({
        log = {
          -- enable = true,
          types = {
            diagnostics = true,
          },
        },
        on_attach = tree_on_attach,
        update_cwd = true,
        disable_netrw = true, -- enable netrw to download spell files
        hijack_netrw = true,
        update_focused_file = {
          enable = true,
          update_cwd = true
        },
        filters = {
          git_ignored = false,
          dotfiles = false,
          git_clean = false,
          no_buffer = false,
          custom = {},
          exclude = {},
        },
        -- Open in new terminal
        system_open = {
          cmd = "kitty",
          args = { "vifm", },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
          icons = {
            hint = "H",
            info = "I",
            warning = "W",
            error = "E",
          },
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
        },
        -- Floating window and borders
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
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
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
          remove_file = {
            close_window = false,
          },
        },
        renderer = {
          icons = {
            glyphs = {
              git = {
                unstaged = "M",
                staged = "S",
                unmerged = "UM",
                renamed = "R",
                untracked = "U",
                deleted = "D",
                ignored = "I",
              }
            }
          }
        },
      })

    end,
  },

  -- https://github.com/akinsho/toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = true,
    config = function()
      require("toggleterm").setup({
        direction = "float",
        shell = "fish",
        autochdir = true,
        shade_terminals = false,
      })
    end,
  },

  -- https://github.com/stevearc/dressing.nvim
  {
    "stevearc/dressing.nvim",
    dependencies = {
      "telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          default_prompt = "Input:",
          insert_only = false,
          -- start_in_insert = false,
          relative = "editor",
          border = "single",
          prefer_width = 50,
          mappings = {
            n = {
              ["<C-c>"] = "Close",
              ["Zq"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },
        },
        select = {
          backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui", },
          telescope = {
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
          trim_prompt = true,
          builtin = {
            show_numbers = true,
            border = "single",
            win_options = {
              winblend = 0,
              cursorline = true,
            },
          },
        },
      })
    end
  },

  -- https://github.com/prochri/telescope-all-recent.nvim
  {
    "prochri/telescope-all-recent.nvim",
    enabled = false,
    dependencies = {
      -- https://github.com/kkharji/sqlite.lua
      "kkharji/sqlite.lua",

      "dressing.nvim",
      "telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("telescope-all-recent").setup {
        database = {
          folder = vim.fn.stdpath("data"),
          file = "telescope-all-recent.sqlite3",
          max_timestamps = 20,
        },
        scoring = {
          boost_factor = 0.0001
        },
        default = {
          disable = true,
          use_cwd = true,
          sorting = "frecency",
        },
        pickers = {
          ["workspaces#workspaces"] = {
            disable = false,
          },
        },
        vim_ui_select = {
          kinds = {
            overseer_template = {
              disable = false,
              use_cwd = true,
              prompt = "Task template",
              name_include_prompt = true,
            },
          },
          -- prompts = {
          --   ["Load session"] = {
          --     use_cwd = false,
          --   },
          -- },
        },
      }
    end,
  },

  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    lazy = true,
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        fold_open = "v",
        fold_closed = ">",
        indent_lines = false,
        focus = true,
        multiline = false,
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        win_config = { border = "single", },
        signs = {
          error = "E",
          warning = "W",
          hint = "H",
          information = "I",
          other = "?",
        },
        action_keys = {
          close = { "q", "Zq", },
          cancel = "<Esc>",             -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r",                -- manually refresh
          jump = "<CR>",                -- jump to the diagnostic or open / close folds
          open_split = "<c-x>",         -- open buffer in new split
          open_vsplit = "<c-v>",        -- open buffer in new vsplit
          open_tab = "<c-t>",           -- open buffer in new tab
          jump_close = "<BS>",          -- jump to the diagnostic and close the list
          toggle_mode = "<Tab>",        -- toggle between "workspace" and "document" diagnostics mode
          switch_severity = "s",        -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
          toggle_preview = "P",         -- toggle auto_preview
          hover = "K",                  -- opens a small popup with the full multiline message
          preview = "p",                -- preview the diagnostic location
          open_code_href = "gx",        -- if present, open a URI with more information about the diagnostic error
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" },  -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k",               -- previous item
          next = "j",                   -- next item
          help = "?",                   -- help menu
        },
        icons = {
          indent        = {
            top         = "│ ",
            middle      = "├╴",
            last        = "└╴",
            fold_open   = " ",
            fold_closed = " ",
            ws          = "  ",
          },
          folder_closed = " ",
          folder_open   = " ",
          kinds         = {
            Array         = " ",
            Boolean       = "󰨙 ",
            Class         = " ",
            Constant      = "󰏿 ",
            Constructor   = " ",
            Enum          = " ",
            EnumMember    = " ",
            Event         = " ",
            Field         = " ",
            File          = " ",
            Function      = "󰊕 ",
            Interface     = " ",
            Key           = " ",
            Method        = "󰊕 ",
            Module        = " ",
            Namespace     = "󰦮 ",
            Null          = " ",
            Number        = "󰎠 ",
            Object        = " ",
            Operator      = " ",
            Package       = " ",
            Property      = " ",
            String        = " ",
            Struct        = "󰆼 ",
            TypeParameter = " ",
            Variable      = "󰀫 ",
          },
        },
      })
    end
  },

  -- https://github.com/AckslD/nvim-neoclip.lua
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      -- https://github.com/kkharji/sqlite.lua
      "kkharji/sqlite.lua",

      "telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("neoclip").setup({
        history = 1000,
        enable_persistent_history = true,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        preview = true,
        default_register = [["]],
        default_register_macros = [[j]],
        enable_macro_history = true,
        keys = {
          telescope = {
            i = {
              select = "<cr>",
            },
            n = {
              select = "<cr>",
              paste = "p",
              paste_behind = "P",
              delete = "d",
            },
          },
        },
      })
    end,
  },

  -- https://github.com/stevearc/oil.nvim
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    config = function()
      require("oil").setup({
        default_file_explorer = false,
        columns = {
          "icon",
          { "size", highlight = "OilSize" },
        },
        win_options = {
          signcolumn = "no",
          cursorcolumn = false,
          list = false,
        },
        delete_to_trash = true,
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 2000,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["L"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["H"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["U"] = function() require("oil").discard_all_changes() end,
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            return name == ".git" or name == ".."
          end,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        float = {
          padding = 5,
          max_width = 80,
          max_height = 32,
          border = "single",
        },
        preview = { border = "single", },
        progress = { border = "single", },
      })
    end,
  }
}
