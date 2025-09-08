-- ~/.config/nvim/lua/gruvw/plugins/highlight_undo.lua

return {
  {
    -- https://github.com/tzachar/highlight-undo.nvim
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    config = function()
      require("highlight-undo").setup({
        duration = vim.g.highlight_timout,
        ignore_cb = function(buf)
          local name = vim.api.nvim_buf_get_name(buf)
          return name:match("%.str$") ~= nil
        end,
      })
    end
  },
}
