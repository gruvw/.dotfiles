-- ~/.config/nvim/lua/gruvw/plugins/runner.lua

return {
  {
    -- https://github.com/stevearc/overseer.nvim
    "stevearc/overseer.nvim",
    lazy = true,
    dependencies = {
      "plenary.nvim",
    },
    config = function()
      local overseer = require("overseer")
      overseer.setup({
        -- TODO use custom templates for cargo and make
        templates = {
          -- "cargo",
          "just",
          "make",
          -- "npm",
          "tox",
          "vscode",
          "mix",
          "deno",
          "rake",
          "task",
          "composer",
          "cargo-make",
        },
        dap = false,
        task_list = {
          default_detail = 1,
          max_width = { 0.3 },
          separator = "",
          direction = "left",
          bindings = {
            ["g?"] = "ShowHelp",
            ["<CR>"] = "RunAction",
            ["c"] = "Edit",
            ["o"] = "Open",
            ["<C-v>"] = "OpenVsplit",
            ["<C-s>"] = "OpenSplit",
            ["<C-f>"] = "OpenFloat",
            ["<C-q>"] = "OpenQuickFix",
            ["p"] = "TogglePreview",
            ["<C-l>"] = "IncreaseDetail",
            ["<C-h>"] = "DecreaseDetail",
            ["L"] = "IncreaseAllDetail",
            ["H"] = "DecreaseAllDetail",
            ["<"] = "DecreaseWidth",
            [">"] = "IncreaseWidth",
            ["{"] = "PrevTask",
            ["}"] = "NextTask",
            ["<C-k>"] = "ScrollOutputUp",
            ["<C-j>"] = "ScrollOutputDown",
          },
        },
        form = {
          border = "single",
          win_opts = { winblend = 0 },
        },
        task_launcher = {
          bindings = {
            i = {
              ["<C-s>"] = "Submit",
              ["<C-c>"] = "Cancel",
            },
            n = {
              ["<CR>"] = "Submit",
              ["<C-s>"] = "Submit",
              ["<C-c>"] = "Cancel",
              ["g?"] = "ShowHelp",
            },
          },
        },
        task_editor = {
          bindings = {
            i = {
              ["<CR>"] = "NextOrSubmit",
              ["<C-s>"] = "Submit",
              ["<C-Tab>"] = "Next",
              ["<C-S-Tab>"] = "Prev",
              ["<C-c>"] = "Cancel",
            },
            n = {
              ["<CR>"] = "NextOrSubmit",
              ["<C-s>"] = "Submit",
              ["<C-Tab>"] = "Next",
              ["<C-S-Tab>"] = "Prev",
              ["<C-c>"] = "Cancel",
              ["g?"] = "ShowHelp",
            },
          },
        },
        confirm = {
          border = "signle",
          win_opts = { winblend = 0 },
        },
        task_win = {
          border = "single",
          win_opts = { winblend = 0 },
        },
        component_aliases = {
          default = {
            "display_duration",
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
          },
          default_vscode = {
            "default",
            "on_result_diagnostics",
            "on_result_diagnostics_quickfix",
          },
        },
      })

      -- Custom templates
      -- Automatically register all Lua modules from the overseer directory
      local overseer_dir = vim.fn.stdpath("config") .. "/lua/gruvw/overseer"
      local dirscan = require("plenary.scandir")
      local files = dirscan.scan_dir(overseer_dir, { depth = 1, add_dirs = false, hidden = false })

      for _, file in ipairs(files) do
        local module_name = file:match("([^/]+)%.lua$")
        if module_name then
          overseer.register_template(require("gruvw.overseer." .. module_name))
        end
      end
    end,
  },
}
