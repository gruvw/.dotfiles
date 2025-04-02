-- ~/.config/nvim/lua/gruvw/plugins/clipboard.lua

return {
  {
    -- https://github.com/AckslD/nvim-neoclip.lua
    "AckslD/nvim-neoclip.lua",
    event = "VeryLazy",
    dependencies = {
      -- https://github.com/kkharji/sqlite.lua
      "kkharji/sqlite.lua",

      "telescope.nvim",
    },
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
}
