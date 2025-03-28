-- ~/.config/nvim/lua/gruvw/plugins/hex.lua

return {
  -- https://github.com/RaafatTurki/hex.nvim
  "RaafatTurki/hex.nvim",
  lazy = true,
  config = function()
    require("hex").setup({})
  end
}
