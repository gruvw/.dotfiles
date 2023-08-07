-- ~/.config/nvim/lua/plugins/motions.lua

return {
  {
    -- https://github.com/ggandor/leap.nvim
    "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")
      leap.add_default_mappings()
      leap.opts.equivalence_classes = {
        "aàâæ",
        "eéèæ",
        "cç{}",
        "p()",
        "b[]",
        " \t\r\n",
      }

      -- Double cursor workaround, https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
      vim.api.nvim_create_autocmd(
        "User",
        { callback = function()
          vim.cmd.hi("Cursor", "blend=100")
          vim.opt.guicursor:append { "a:Cursor/lCursor" }
          end,
          pattern = "LeapEnter"
        }
      )
      vim.api.nvim_create_autocmd(
        "User",
        { callback = function()
          vim.cmd.hi("Cursor", "blend=0")
          vim.opt.guicursor:remove { "a:Cursor/lCursor" }
          end,
          pattern = "LeapLeave"
        }
      )
    end,
  },
  {
    -- https://github.com/kylechui/nvim-surround
    "kylechui/nvim-surround",
    opts = {
       keymaps = {
        insert = "<C-g>z",
        insert_line = "gC-ggZ",
        normal = "gz",
        normal_cur = "gZ",
        normal_line= "gzz",
        normal_cur_line = "gZZ",
        visual = "gz",
        visual_line = "gZ",
        delete = "gzd",
        change = "gzr",
      }
    },
  },
}
