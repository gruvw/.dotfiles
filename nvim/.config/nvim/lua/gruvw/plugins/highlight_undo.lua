-- ~/.config/nvim/lua/gruvw/plugins/highlight_undo.lua

return {
  {
    -- https://github.com/tzachar/highlight-undo.nvim
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    config = function()
      require("highlight-undo").setup({
        duration = vim.g.highlight_timout,
      })
    end
  },
}
