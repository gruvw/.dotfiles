-- ~/.config/nvim/lua/gruvw/plugins/treesitter.lua

return {
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
        indent = {
          enable = false,
        },
        textobjects = {
          select = {
            enable = true,
            disable = { "dart", }, -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
              ["ib"] = "@block.inner",
              ["ab"] = "@block.outer",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
            },
          },
        },
      })
    end,
  },

  {
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter",
    },
    event = "VeryLazy",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        mode = "topline",
        max_lines = 4,
      })
    end,
  },
}
