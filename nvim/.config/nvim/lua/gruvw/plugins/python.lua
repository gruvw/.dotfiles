-- ~/.config/nvim/lua/gruvw/plugins/python.lua

return {
  {
  -- https://github.com/kiyoon/jupynium.nvim
    "kiyoon/jupynium.nvim",
    config = function()
      require("jupynium").setup({
        python_host = vim.fn.expand("~/.venvs/jupynium/bin/python"),
        default_notebook_URL = "localhost:8888/nbclassic",
      })
    end
  },
}
