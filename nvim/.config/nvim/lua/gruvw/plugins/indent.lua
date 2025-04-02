-- ~/.config/nvim/lua/gruvw/plugins/indent.lua

return {
  {
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        scope = {
          -- highlight current scope lines
          enabled = false,
        },
        indent = {
          char = "▏",
          -- custom highlight groups, config in theme
          highlight = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
          },
        },
        exclude = {
          filetypes = {
            "lspinfo",
            "packer",
            "checkhealth",
            "help",
            "man",
            "",
          },
        },
      })
    end
  },
}
