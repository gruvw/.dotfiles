-- ~/.config/nvim/lua/plugins/colors.lua

return {
  -- https://github.com/loctvl842/monokai-pro.nvim
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      -- Setup and enable
      require("monokai-pro").setup({
        filter = "spectrum",
        background_clear = {
          "float_win",
        },
      })
      vim.cmd("colorscheme monokai-pro")

      -- Only highlight the line number not whole current line
      vim.cmd("highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE")

      -- Windows line separator in white
      vim.cmd("highlight WinSeparator guifg=15")
    end,
  },
}
