-- ~/.config/nvim/lua/gruvw/plugins/theme.lua

return {
  {
    "chromance.nvim",
    dev = true,
    priority = 101,
    config = function()
      require("chromance").setup({
        devicons = true,
      })

      vim.cmd("colorscheme chromance")
    end
  },
  {
    "loctvl842/monokai-pro.nvim",
    enabled = false,
    priority = 100,
    config = function()
      require("monokai-pro").setup({
        filter = "spectrum",
      })

      vim.cmd([[colorscheme monokai-pro]])
    end
  },
}
