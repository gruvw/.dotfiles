-- ~/.config/nvim/lua/plugins/code.lua

return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            disable = { "dart", }, -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
              ["ib"] = "@block.inner",
              ["ab"] = "@block.outer",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
            },
          },
        },
      })
    end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter",
    },
    event = "VeryLazy",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        mode = "topline",
        max_lines = 4,
      })
    end,
  },

  -- https://github.com/terrortylor/nvim-comment
  {
    "terrortylor/nvim-comment",
    event = "VeryLazy",
    config = function()
      require("nvim_comment").setup({
        marker_padding = true,
        comment_empty = false,
        create_mappings = false,
      })
    end,
  },

  -- https://github.com/stevearc/overseer.nvim
  {
    "stevearc/overseer.nvim",
    lazy = true,
    config = function()
      local overseer = require("overseer")
      overseer.setup({
        templates = { "builtin" },
        task_list = {
          default_detail = 1,
          max_width = { 0.3 },
          separator = "",
          direction = "left",
          bindings = {
            ["g?"] = "ShowHelp",
            ["<CR>"] = "RunAction",
            ["c"] = "Edit",
            ["o"] = "Open",
            ["<C-v>"] = "OpenVsplit",
            ["<C-s>"] = "OpenSplit",
            ["<C-f>"] = "OpenFloat",
            ["<C-q>"] = "OpenQuickFix",
            ["p"] = "TogglePreview",
            ["<C-l>"] = "IncreaseDetail",
            ["<C-h>"] = "DecreaseDetail",
            ["L"] = "IncreaseAllDetail",
            ["H"] = "DecreaseAllDetail",
            ["<"] = "DecreaseWidth",
            [">"] = "IncreaseWidth",
            ["{"] = "PrevTask",
            ["}"] = "NextTask",
            ["<C-k>"] = "ScrollOutputUp",
            ["<C-j>"] = "ScrollOutputDown",
          },
        },
        form = {
          border = "single",
          win_opts = { winblend = 0 },
        },
        task_launcher = {
          bindings = {
            i = {
              ["<C-s>"] = "Submit",
              ["<C-c>"] = "Cancel",
            },
            n = {
              ["<CR>"] = "Submit",
              ["<C-s>"] = "Submit",
              ["<C-c>"] = "Cancel",
              ["g?"] = "ShowHelp",
            },
          },
        },
        task_editor = {
          bindings = {
            i = {
              ["<CR>"] = "NextOrSubmit",
              ["<C-s>"] = "Submit",
              ["<C-Tab>"] = "Next",
              ["<C-S-Tab>"] = "Prev",
              ["<C-c>"] = "Cancel",
            },
            n = {
              ["<CR>"] = "NextOrSubmit",
              ["<C-s>"] = "Submit",
              ["<C-Tab>"] = "Next",
              ["<C-S-Tab>"] = "Prev",
              ["<C-c>"] = "Cancel",
              ["g?"] = "ShowHelp",
            },
          },
        },
        confirm = {
          border = "signle",
          win_opts = { winblend = 0 },
        },
        task_win = {
          border = "single",
          win_opts = { winblend = 0 },
        },
        component_aliases = {
          default = {
            "display_duration",
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
          },
          default_vscode = {
            "default",
            "on_result_diagnostics",
            "on_result_diagnostics_quickfix",
          },
        },
      })

      -- Custom templates
      local templates = {
        "python",
        "tex",
        "md"
      }
      for _, t in ipairs(templates) do
        overseer.register_template(require("gruvw.overseer." .. t))
      end
    end,
  },
}
