-- ~/.config/nvim/lua/gruvw/overseer/flutter.lua

local overseer = require("overseer")
local pubspec = "/pubspec.yaml"

return {
  name = "Flutter Run",
  generator = function(opts, cb)
    local cwd = vim.fn.getcwd()
    local files = vim.split(vim.fn.glob(cwd .. "/**" .. pubspec), "\n", { trimempty = true })

    local res = {}

    for _, file in ipairs(files) do
      local directory = string.sub(file, 0, #file - #pubspec)
      local name = "./" .. string.sub(directory, #cwd + 2)

      -- flutter pub get
      table.insert(res, {
        name = "Flutter Pub Get " .. name,
        builder = function()
          return {
            name = "Flutter Pub Get",
            cwd = directory,
            cmd = { "flutter", },
            args = { "pub", "get" },
          }
        end,
      })

      -- flutter run web
      table.insert(res, {
        name = "Flutter Run Web " .. name,
        builder = function()
          return {
            name = "Flutter Run Web " .. name,
            cwd = directory,
            cmd = { "flutter", },
            args = { "run", "-d", "chrome" },
            env = {
              CHROME_EXECUTABLE = os.getenv("CHROME_EXECUTABLE") or "/opt/brave.com/brave/brave-browser",
            },
          }
        end,
        tags = { overseer.TAG.RUN },
      })
    end

    cb(res)
  end,
}
