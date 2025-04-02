-- ~/.config/nvim/lua/gruvw/plugins/workspace.lua

return {
  {
    -- https://github.com/natecraddock/workspaces.nvim
    "natecraddock/workspaces.nvim",
    dependencies = {
      "telescope.nvim",
    },
    lazy = true,
    config = function()
      require("workspaces").setup({
        path = vim.fn.stdpath("data") .. "/workspaces",
        cd_type = "global",
        hooks = {
          open = {
            [[lua require("telescope.builtin").find_files()]],
          },
        },
      })

      require("telescope").load_extension("workspaces")
    end,
  },
}
