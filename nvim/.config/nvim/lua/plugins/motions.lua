-- ~/.config/nvim/lua/plugins/motions.lua

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
        "aàâæ",
        "eéèæê",
        "cç{}",
        "p()",
        "b[]",
        " \t\r\n",
      }

      -- Double cursor workaround, https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
      vim.api.nvim_create_autocmd("User", {
        pattern = "LeapEnter",
        callback = function()
          vim.cmd.hi("Cursor", "blend=100")
          vim.opt.guicursor:append { "a:Cursor/lCursor" }
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "LeapLeave",
        callback = function()
          vim.cmd.hi("Cursor", "blend=0")
          vim.opt.guicursor:remove { "a:Cursor/lCursor" }
        end,
      })
    end,
  },

  -- https://github.com/kylechui/nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      keymaps = {
        normal = "gs",
        normal_cur = "gS",
        normal_line = "gss",
        normal_cur_line = "gSS",
        visual = "gs",
        visual_line = "gS",
        delete = "gsd",
        change = "gsr",
      }
    },
  },

  -- https://github.com/windwp/nvim-autopairs
  {
    -- enabled = false,
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end
  },
}
