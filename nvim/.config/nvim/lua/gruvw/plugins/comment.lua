-- ~/.config/nvim/lua/gruvw/plugins/workspace.lua

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
  }
}
