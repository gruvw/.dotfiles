-- ~/.config/nvim/lua/gruvw/plugins/pairs.lua

return {
  -- https://github.com/windwp/nvim-autopairs
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup()
  end
}
