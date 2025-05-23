-- ~/.config/nvim/lua/gruvw/plugins/comment.lua

return {
  {
    -- https://github.com/terrortylor/nvim-comment
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

  {
    -- https://github.com/folke/todo-comments.nvim
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = {
      "plenary.nvim",
      "telescope.nvim",
    },
    config = function()
      require("todo-comments").setup({
        signs = false,
        merge_keywords = false,
        colors = {},
        highlight = {
          multiline = false,
          before = "",
          keyword = "bg",
          after = "fg",
          pattern = [[\s*<(KEYWORDS)\s*:?]],
          comments_only = true,
          exclude = {}, -- list of filetypes to exclude highlighting
        },
        keywords = {
          TODO = {
            icon = "T",
            color = "#fc618d",
            alt = { "todo", },
          },
          FIX = {
            icon = "F",
            color = "#fce566",
            alt = { "FIXME", "FIXIT", "ISSUE", "CHANGE", },
          },
          BUG = {
            icon = "B",
            color = "#5ad4e6",
          },
          ASK = {
            icon = "A",
            color = "#5ad4e6",
          },
          PAUSED = {
            icon = "P",
            color = "#fd9353",
            alt = { "PAUSE", "LEFT", "LEFT HERE", "PAUSED HERE", }
          },
          WARN = {
            icon = "W",
            color = "#fd9353",
            alt = { "WARNING", "XXX", },
          },
          NOTE = {
            icon = "N",
            color = "#787878",
            alt = { "INFO", },
          },
        },
        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS)\s*:?]],
        },
      })
    end
  },
}
