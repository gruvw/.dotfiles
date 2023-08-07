-- ~/.config/nvim/lua/plugins/colors.lua

return {
    -- https://github.com/loctvl842/monokai-pro.nvim
    "loctvl842/monokai-pro.nvim",
    config = function()
        require("monokai-pro").setup({
            filter = "spectrum",
        })
        vim.cmd([[colorscheme monokai-pro]])
    end,
}
