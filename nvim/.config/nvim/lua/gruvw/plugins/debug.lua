-- ~/.config/nvim/lua/gruvw/plugins/debug.lua

return {
  {
    -- https://github.com/mfussenegger/nvim-dap
    "mfussenegger/nvim-dap",
    enabled = false,
    lazy = true,
    dependencies = {
      -- https://github.com/rcarriga/nvim-dap-ui
      "rcarriga/nvim-dap-ui",

      "overseer.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Signs
      vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "Error", })
      vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "Error", })
      vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "", })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "Error", })
      vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "Error", })

      require("overseer").patch_dap(true)
      require("dap.ext.vscode").json_decode = require("overseer.json").decode

      dapui.setup({
        controls = {
          enabled = false,
        },
      })

      -- Open close automagically
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
