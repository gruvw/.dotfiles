-- ~/.config/nvim/lua/gruvw/plugins/treesitter.lua

return {
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "stable", "unstable" })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("gruvw_treesitter", { clear = true }),
        callback = function(args)
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end

          -- was: textobjects.select.disable = { "dart" }
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
         -- if vim.bo[args.buf].filetype == "dart" then
         --    return
         --  end

          -- local select = require("nvim-treesitter-textobjects.select")
          -- local function map(lhs, query, group, desc)
          --   vim.keymap.set({ "x", "o" }, lhs, function()
          --     select.select_textobject(query, group or "textobjects")
          --   end, { buffer = args.buf, desc = desc })
          -- end

          -- map("af", "@function.outer")
          -- map("if", "@function.inner")
          -- map("ac", "@class.outer")
          -- map("ic", "@class.inner", nil, "Select inner part of a class region")
          -- map("as", "@scope", "locals", "Select language scope")
          -- map("ib", "@block.inner")
          -- map("ab", "@block.outer")
          -- map("il", "@loop.inner")
          -- map("al", "@loop.outer")
        end,
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
