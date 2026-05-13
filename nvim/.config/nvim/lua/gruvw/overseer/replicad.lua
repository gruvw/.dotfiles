-- ~/.config/nvim/lua/gruvw/overseer/replicad.lua

local overseer = require("overseer")

return {
  name = "Replicad build",
  generator = function(opts, cb)
    local cwd = vim.fn.getcwd()
    local files = vim.split(vim.fn.glob(cwd .. "/**/*.rcad.js"), "\n", { trimempty = true })

    local res = {}

    for _, file in ipairs(files) do
      local filename = string.sub(file, #cwd + 2)
      local name = "Replicad " .. filename

      table.insert(res, {
        name = name,
        builder = function(params)
          local args = params.args or {}
          table.insert(args, file)

          return {
            name = name,
            cmd = { "replicad-cli" },
            args = {
              "-f", "step",
              filename,
            },
          }
        end,
        tags = { overseer.TAG.BUILD },
      })
    end

    cb(res)
  end,
}
