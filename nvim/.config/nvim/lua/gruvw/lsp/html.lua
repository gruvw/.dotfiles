-- ~/.config/nvim/lua/gruvw/lsp/html.lua

return {
  opts = {
    settings = {
      html = {
        format = {
          templating = true,
        },
        hover = {
          documentation = true,
          references = true,
        },
      },
    },
  }
}
