-- ~/.config/nvim/lua/plugins/files.lua

return {
  -- https://github.com/okuuva/auto-save.nvim
  {
    "okuuva/auto-save.nvim",
    opts = {
      enabled = true,
      execution_message = {
        message = function()
          return "saved"
        end,
      },
      cleaning_interval = 3000, -- time before erasing the execution msg
      debounce_delay = 10000, -- time till a defered save acctually happens (if not cancelled)
    },
  },

  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = {
      -- https://github.com/nvim-lua/plenary.nvim
      "nvim-lua/plenary.nvim",

      -- https://github.com/debugloop/telescope-undo.nvim
      "debugloop/telescope-undo.nvim",
    },
    lazy = true,
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          initial_mode = "normal", -- open telescope in normal mode
          mappings = {
            n = {
              -- Disable escape to quit and map to normal quit keybind
              ["<esc>"] = false,
              ["Zq"] = require("telescope.actions").close,
            },
          },
        },
        extensions = {
          undo = {
            -- use_delta = true,
            -- side_by_side = true,
            layout_strategy = "vertical",
            diff_context_lines = 4,
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
  },

  -- https://github.com/ThePrimeagen/harpoon
  {
    "ThePrimeagen/harpoon",
    lazy = true,
  },
}
