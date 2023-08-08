-- ~/.config/nvim/lua/plugins/colors.lua

return {
  -- https://github.com/loctvl842/monokai-pro.nvim
  "loctvl842/monokai-pro.nvim",
  config = function()
    require("monokai-pro").setup({
      filter = "spectrum",
    })
    vim.cmd("colorscheme monokai-pro")

    -- Customize

    -- Only highlight the line number not whole current line
    vim.cmd([[highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE]])
  end,
}
