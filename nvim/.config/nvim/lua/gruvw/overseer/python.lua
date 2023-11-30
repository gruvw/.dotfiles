-- ~/.config/nvim/lua/gruvw/overseer/python.lua

local overseer = require("overseer")

return {
  name = "Python script generator",
  generator = function(opts, cb)
    local cwd = vim.fn.getcwd()
    local files = vim.split(vim.fn.glob(cwd .. "/**/*.py"), "\n", { trimempty = true })

    local res = {}

    for _, file in ipairs(files) do
      local filename = string.sub(file, #cwd + 2)

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
          table.insert(args, file)

          return {
            name = "Python " .. filename,
            cmd = { "python3" },
            args = args,
          }
        end,
        tags = { overseer.TAG.BUILD },
      })
    end

    cb(res)
  end,
}
