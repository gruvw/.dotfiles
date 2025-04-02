-- ~/.config/nvim/lua/gruvw/plugins/rooter.lua

return {
  {
    -- https://github.com/notjedi/nvim-rooter.lua
    "notjedi/nvim-rooter.lua",
    lazy = true,
    config = function()
      require("nvim-rooter").setup({
        manual = true,
        rooter_patterns = { ".git", ".root", "latex-img", }, -- not "lib" as linux root
        trigger_patterns = { "*", },
        fallback_to_parent = true,
        update_cwd = true,
      })
    end
  }
}
