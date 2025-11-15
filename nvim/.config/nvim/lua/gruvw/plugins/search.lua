-- ~/.config/nvim/lua/gruvw/plugins/search.lua

return {
  {
    -- https://github.com/nvim-telescope/telescope.nvim
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    lazy = true,
    dependencies = {
      -- https://github.com/debugloop/telescope-undo.nvim
      "debugloop/telescope-undo.nvim",

      "plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          -- initial_mode = "normal", -- open telescope in normal mode
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          sorting_strategy = "ascending",
          file_ignore_patterns = { "^.git/", },
          layout_config = {
            height = 0.6,
            prompt_position = "top",
          },
          mappings = {
            n = {
              -- Disable escape to quit and map to normal quit keybind
              ["<esc>"] = false,
              ["Zq"] = require("telescope.actions").close,
              ["<C-c>"] = require("telescope.actions").close,
              ["<leader><CR>"] = function(args)
                local action_state = require("telescope.actions.state")
                system_open(action_state.get_selected_entry().value)
                require("telescope.actions").close(args)
              end
            },
            i = {
              ["<C-c>"] = require("telescope.actions").close,
            }
          },
        },
        pickers = {
          find_files = {
            hidden = true
          },
          live_grep = {
            additional_args = function(opts)
              return { "--hidden", }
            end
          },
        },
        extensions = {
          undo = {
            -- use_delta = true,
            -- side_by_side = true,
            layout_strategy = "vertical",
            vim_diff_opts = {
              ctxlen = 4,
            },
            entry_format = "state #$ID, $STAT, $TIME",
            mappings = {
              n = {
                ["uy"] = require("telescope-undo.actions").yank_additions,
                ["ud"] = require("telescope-undo.actions").yank_deletions,
                ["ur"] = require("telescope-undo.actions").restore,
              },
            },
          },
        },
      })

      -- Load extensions
      telescope.load_extension("undo")
    end,
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
        },
      }
    end,
  },
}
