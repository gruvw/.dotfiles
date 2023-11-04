-- ~/.config/nvim/lua/gruvw/overseer/md.lua

local overseer = require("overseer")

return {
  name = "Markdown To PDF",
  generator = function(opts, cb)
    local cwd = vim.fn.getcwd()
    local files = vim.split(vim.fn.glob(cwd .. "/**/*.md"), "\n", { trimempty = true })

    local res = {}

    for _, file in ipairs(files) do
      local filename = string.sub(file, #cwd + 2)
      local name = "Markdown to PDF " .. filename

      table.insert(res, {
        name = name,
        builder = function(params)
          local args = params.args or {}
          table.insert(args, file)

          return {
            name = name,
            cmd = { "pandoc" },
            args = {
              "-V",
              "block-headings",
              "-f",
              "markdown-implicit_figures",
              filename,
              "-o",
              string.sub(filename, 1, #filename - 2) .. "pdf",
            },
          }
        end,
        tags = { overseer.TAG.BUILD },
      })
    end

    cb(res)
  end,
}
