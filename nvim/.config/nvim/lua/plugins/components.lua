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

-- File type, LSP, spell check, overseer
local filetype_cmpnt = {
  "filetype",
  icon = { align = "left", },
  fmt = function(s)
    -- LSP
    -- Show "+" if LSP client is running, "~" when progress
    local lsp = ""
    if #vim.lsp.buf_get_clients() > 0 then
      local progress = require("lsp-progress").progress({
        format = function(messages)
          return #messages > 0
        end,
      })

      lsp = progress and "~" or "+"
    else
      lsp = "-"
    end

    -- Spell check
    local spell = ""
    if vim.o.spell then
      spell = "s"
    end

    -- Overseer status
    local tasks = require("overseer.task_list").list_tasks({ unique = true, })
    local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
    local status = ""
    if tasks_by_status["RUNNING"] then
      status = " R"
    elseif tasks_by_status["FAILURE"] then
      status = " F"
    elseif tasks_by_status["SUCCESS"] then
      status = " S"
    end

    -- Copilot
    local copilot = ""
    if vim.g.copilot_enabled == 1 then
      copilot = "*"
    end

    return spell .. lsp .. copilot .. status
  end,
}

-- File name
local filename_cmpnt = {
  "filename",
  symbols = {
    modified = "+",
    readonly = "-",
    unnamed = "[No Name]",
    newfile = "[New]",
  },
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

      -- https://github.com/linrongbin16/lsp-progress.nvim
      "linrongbin16/lsp-progress.nvim",

      "overseer.nvim",
    },
    config = function()
      require("lsp-progress").setup()

      require("lualine").setup({
        options = {
          theme = "monokai-pro",
          globalstatus = true,
          icons_enabled = true,
          section_separators = { left = "", right = "", },
          component_separators = { left = "|", right = "|", },
          refresh = {
            statusline = 500,
            tabline = 500,
            winbar = 500,
          }
        },
        extensions = {
          "trouble",
          "fugitive",
          "lazy",
          "man",
          "mason",
          "nvim-dap-ui",
          "overseer",
        },
        sections = {
          lualine_a = { mode_cmpnt, },
          lualine_b = { "branch", },
          lualine_c = { filename_cmpnt, "diff", },
          lualine_x = { "diagnostics", filetype_cmpnt, },
          lualine_y = { progress_cmpnt, },
          lualine_z = { "location", },
        },
      })
    end
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

      -- Sets root directory automagically
      require("nvim-rooter").setup({
        rooter_patterns = { ".git", ".root", "latex-img", "src" }, -- not "lib" as linux root
        trigger_patterns = { "*", },
        fallback_to_parent = true,
        update_cwd = true,
      })

      vim.api.nvim_create_autocmd({ "BufEnter", }, {
        group = vim.api.nvim_create_augroup("nvim_rooter", { clear = true, }),
        callback = function()
          -- Don't call in floating window buffers
          if vim.api.nvim_win_get_config(vim.fn.win_getid()).zindex then
            return
          end

          -- Find and set cwd
          require("nvim-rooter").rooter_default()

          -- Load local config
          local_config()
        end,
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
        modes = { ":", "/", "?", },
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
            accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#7bd88f", }, }),
            border = "Normal",
          },
          border = "single",
          reverse = 1,
          max_height = "25%",
        })
      ))
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
        icons = false,
        mode = "workspace_diagnostics",
        fold_open = "v",
        fold_closed = ">",
        indent_lines = false,
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
