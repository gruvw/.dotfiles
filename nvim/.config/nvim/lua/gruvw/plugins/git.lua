-- ~/.config/nvim/lua/gruvw/plugins/git.lua

return {
  {
    -- https://github.com/tpope/vim-fugitive
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },

  {
    -- https://github.com/lewis6991/gitsigns.nvim
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
