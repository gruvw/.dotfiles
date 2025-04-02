-- ~/.config/nvim/lua/gruvw/plugins/harpoon.lua

return {
  {
    -- https://github.com/ThePrimeagen/harpoon
    "ThePrimeagen/harpoon",
    dependencies = {
      "telescope.nvim",
    },
    lazy = true,
    config = function()
      require("telescope").load_extension("harpoon")
    end,
  },
}
