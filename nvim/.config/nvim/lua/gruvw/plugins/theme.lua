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
}
