-- ~/.config/nvim/lua/gruvw/plugins/format.lua

return {
  {
    -- https://github.com/stevearc/conform.nvim
    "stevearc/conform.nvim",
    lazy = true,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          javascript = { "prettier" },
          c = { "clang_format" },
          typst = { "typstyle" },
        },
        formatters = {
          typstyle = {
            command = "typstyle",
          }
        }
      })
    end
  },
}
