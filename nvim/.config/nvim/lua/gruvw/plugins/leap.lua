-- ~/.config/nvim/lua/gruvw/plugins/leap.lua

return {
  -- https://github.com/ggandor/leap.nvim
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      local leap = require("leap")
      leap.add_default_mappings()

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
