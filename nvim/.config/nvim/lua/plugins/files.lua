-- ~/.config/nvim/lua/plugins/files.lua

return {
  -- https://github.com/okuuva/auto-save.nvim
  {
    "okuuva/auto-save.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      execution_message = {
        message = function()
          return "saved"
        end,
      },
      trigger_events = {
        immediate_save = {"BufLeave", "FocusLost"},
        defer_save = {"InsertLeave", "TextChanged"},
        cancel_defered_save = {"ModeChanged"},
      },
      cleaning_interval = 3000, -- time before erasing the execution msg
      debounce_delay = 6000, -- time till a defered save acctually happens (if not cancelled)
      condition = function(buf)
        -- Ignore auto-save
        local ignore_buftype = {}
        local ignore_filetype = {}

        if vim.tbl_contains(ignore_buftype, vim.bo.buftype)
          or vim.tbl_contains(ignore_filetype, vim.bo.filetype)
        then
          return false
        end

        return true
      end,
    },
  },

  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    lazy = true,
    dependencies = {
      -- https://github.com/nvim-lua/plenary.nvim
      "nvim-lua/plenary.nvim",

      -- https://github.com/debugloop/telescope-undo.nvim
      "debugloop/telescope-undo.nvim",

      "workspaces.nvim",
      "harpoon",
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          -- initial_mode = "normal", -- open telescope in normal mode
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
      telescope.load_extension("workspaces")
      telescope.load_extension("harpoon")
    end
  },

  -- https://github.com/natecraddock/workspaces.nvim
  {
    "natecraddock/workspaces.nvim",
    lazy = true,
    config = function()
      require("workspaces").setup({
        path = vim.fn.stdpath("data") .. "/workspaces",
        cd_type = "global",
        hooks = {
          open = {
            [[lua require("telescope.builtin").find_files()]],
          },
        },
      })
    end,
  },

  -- https://github.com/ThePrimeagen/harpoon
  {
    "ThePrimeagen/harpoon",
    lazy = true,
  },

  -- https://github.com/tpope/vim-fugitive
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },

  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame_formatter = '<author> - <author_time:%Y_%m_%d> <author_time:%H:%M> - <summary>',
         current_line_blame_opts = {
          delay = 300,
        },
      })
    end,
  },
}
