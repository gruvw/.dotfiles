-- ~/.config/nvim/lua/gruvw/plugins/ai.lua

return {
  {
    -- https://github.com/github/copilot.vim
    "github/copilot.vim",
    keys = {
      { "<leader>Ce", ":Copilot enable<CR>" },
    },
    config = function()
      vim.g.copilot_no_tab_map = true
    end
  },
}
