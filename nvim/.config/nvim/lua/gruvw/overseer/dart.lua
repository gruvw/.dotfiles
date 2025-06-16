-- ~/.config/nvim/lua/gruvw/overseer/dart.lua

local overseer = require("overseer")
local pubspec = "/pubspec.yaml"

return {
  name = "Flutter Run",
  generator = function(opts, cb)
    local cwd = vim.fn.getcwd()
    local pubspec_files = vim.split(vim.fn.glob(cwd .. "/**" .. pubspec), "\n", { trimempty = true })
    local dart_files = vim.split(vim.fn.glob(cwd .. "/**/*.dart"), "\n", { trimempty = true })

    local res = {}

    if #pubspec_files < 1 then -- avoid flutter projects
      for _, file in ipairs(dart_files) do
        local name = "./" .. string.sub(file, #cwd + 2)

        table.insert(res, {
          name = "Dart Run " .. name,
          builder = function()
            return {
              name = "Dart Run " .. name,
              cmd = { "dart", },
              args = { "run", file },
            }
          end,
          tags = { overseer.TAG.RUN },
        })
      end
    end

    cb(res)
  end,
}
