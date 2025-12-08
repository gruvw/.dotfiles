-- ~/.config/nvim/lua/gruvw/plugins/http.lua

return {
  {
    -- https://github.com/mistweaverco/kulala.nvim
    "mistweaverco/kulala.nvim",
    lazy = true,
    config = function()
      require("kulala").setup({
        global_keymaps = false,
      })
    end
  },
}
