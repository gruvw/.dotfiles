-- ~/.config/nvim/lua/gruvw/plugins/highlight-undo.lua

return {
  -- https://github.com/tzachar/highlight-undo.nvim
  "tzachar/highlight-undo.nvim",
  event = "VeryLazy",
  config = function()
    require("highlight-undo").setup({
      duration = 300,
    })
  end
};
