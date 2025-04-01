-- ~/.config/nvim/lua/gruvw/plugins/telescope.lua

return {
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
        -- FIXME disable borders while waiting for https://github.com/nvim-telescope/telescope.nvim/issues/3436
        border = false,
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
  end
}
