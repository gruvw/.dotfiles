-- ~/.config/nvim/lua/gruvw/plugins/dressing.lua

return {
  {
    -- https://github.com/stevearc/dressing.nvim
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
}
