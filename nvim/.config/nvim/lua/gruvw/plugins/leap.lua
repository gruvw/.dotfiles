-- ~/.config/nvim/lua/gruvw/plugins/leap.lua

return {
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    event = "VeryLazy",
    config = function()
      local leap = require("leap")

      -- Defines characters considered equivalent when searching
      leap.opts.equivalence_classes = {
        " \t\r\n",
        "aàâæ<>@&",
        "b[]\\|",
        "cç{}:^,",
        "d.$\"-",
        "eéèæê=!",
        "h#",
        "m-",
        "p()+%",
        "q?",
        "s/';",
        "t*~",
        "u_",
      }
    end,
  },
}
