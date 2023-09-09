-- ~/.config/nvim/lua/gruvw/overseer/tex.lua

local overseer = require("overseer")
local files = require("overseer.files")

return {
  name = "Tex file generator",
  generator = function(opts, cb)
    local scripts = vim.tbl_filter(
      function(filename)
        return filename:match("%.tex$")
      end,
      files.list_files(opts.dir)
    )

    local res = {}

    for _, filename in ipairs(scripts) do
      table.insert(res, {
        name = "Tex " .. filename,
        builder = function(params)
          return {
            name = "Tex " .. filename,
            cmd = {"xelatex"},
            args = {
              "-synctex=1",
              "-interaction=nonstopmode",
              "-file-line-error",
              "-pdf",
              "--shell-escape",
              "-outdir=" .. files.join(opts.dir, "out"),
              files.join(opts.dir, filename),
            },
          }
        end,
        tags = {overseer.TAG.BUILD},
      })
    end

    cb(res)
  end,
}
