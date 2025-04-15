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
          highlight = {
            "IndentBlankLineIndent1",
            "IndentBlankLineIndent2",
            "IndentBlankLineIndent3",
            "IndentBlankLineIndent4",
            "IndentBlankLineIndent5",
            "IndentBlankLineIndent6",
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
