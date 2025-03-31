-- ~/.config/nvim/lua/gruvw/plugins/surround.lua

return {
  -- https://github.com/kylechui/nvim-surround
  "kylechui/nvim-surround",
  version = "^3.0.0",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        normal = "gs",
        normal_cur = "gss",
        normal_line = "gS",
        normal_cur_line = "gSS",
        visual = "gs",
        visual_line = "gS",
        delete = "gsd",
        change = "gsr",
      },
    })
  end
}
