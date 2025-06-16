-- ~/.config/nvim/lua/gruvw/overseer/c.lua

local overseer = require("overseer")

return {
  name = "NDS Debug",
  generator = function(opts, cb)
    local cwd = vim.fn.getcwd()
    local files = vim.split(vim.fn.glob(cwd .. "/**/*.nds"), "\n", { trimempty = true })

    local res = {}

    for _, file in ipairs(files) do
      local filename = string.sub(file, #cwd + 2)

      table.insert(res, {
        name = "NDS debug " .. filename,
        builder = function()

          vim.cmd([[silent exec "!nohup desmume ]] .. filename .. [[ --arm9gdb 1800 &>/dev/null &"]])
          require("dap").continue()

          return {
            name = "NDS debug " .. filename,
            cmd = {
              "make",
            },
            args = {
            },
          }
        end,
        tags = { overseer.TAG.RUN },
      })
    end

    cb(res)
  end,
}
