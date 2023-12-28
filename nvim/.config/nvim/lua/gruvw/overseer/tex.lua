-- ~/.config/nvim/lua/gruvw/overseer/tex.lua

local overseer = require("overseer")

return {
  name = "Tex file generator",
  generator = function(opts, cb)
    local cwd = vim.fn.getcwd()
    local files = vim.split(vim.fn.glob(cwd .. "/**/*.tex"), "\n", { trimempty = true, })

    local res = {}

    for _, file in ipairs(files) do
      local filename = string.sub(file, #cwd + 2)
      local name = "Tex " .. filename

      if string.find(file, "parts/") == nil then -- avoid compiling parts of document
        table.insert(res, {
          name = name,
          builder = function(params)
            -- Create out for xelatex (if not present)
            vim.cmd([[silent exec "!mkdir out"]])

            return {
              name = name,
              cmd = { "latexmk" },
              args = {
                "-xelatex",
                "-synctex=1",
                -- "-interaction=nonstopmode",
                -- "-file-line-error",
                "--shell-escape",
                "-output-directory=out",
                file,
              },
            }
          end,
          tags = { overseer.TAG.BUILD },
        })
      end
    end

    cb(res)
  end,
}
