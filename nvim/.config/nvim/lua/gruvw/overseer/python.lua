-- ~/.config/nvim/lua/gruvw/overseer/python.lua

local overseer = require("overseer")
local files = require("overseer.files")

return {
  name = "Python script generator",
  generator = function(opts, cb)
    local scripts = vim.tbl_filter(
      function(filename)
        return filename:match("%.py$")
      end,
      files.list_files(opts.dir)
    )

    local res = {}

    for _, filename in ipairs(scripts) do
      table.insert(res, {
        name = "Python " .. filename,
        params = {
          args = {
            optional = true,
            type = "list",
            delimiter = " "
          },
        },
        builder = function(params)
          local args = params.args or {}
          table.insert(args, files.join(opts.dir, filename))
          return {
            name = "Python " .. filename,
            cmd = {"python"},
            args = args,
          }
        end,
        tags = {overseer.TAG.BUILD},
      })
    end

    cb(res)
  end,
}
