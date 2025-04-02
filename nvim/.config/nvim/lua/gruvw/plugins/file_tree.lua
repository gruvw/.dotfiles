-- ~/.config/nvim/lua/gruvw/plugins/file_tree.lua

-- Nvim-tree
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
  {
    -- https://github.com/nvim-tree/nvim-tree.lua
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
