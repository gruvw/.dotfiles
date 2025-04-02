-- ~/.config/nvim/lua/gruvw/plugins/terminal.lua

return {
  {
    -- https://github.com/akinsho/toggleterm.nvim
    "akinsho/toggleterm.nvim",
    lazy = true,
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        shell = "fish",
        autochdir = true,
        shade_terminals = false,
      })
    end,
  },
}
