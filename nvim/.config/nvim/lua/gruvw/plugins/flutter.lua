-- ~/.config/nvim/lua/gruvw/plugins/flutter.lua

return {
  {
    -- https://github.com/nvim-flutter/flutter-tools.nvim
    "nvim-flutter/flutter-tools.nvim",
    dependencies = {
      "plenary.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "single",
          notification_style = "native",
        },
        debugger = {
          enabled = false,
          run_via_dap = false,
        },
        lsp = {
          settings = {
            showTodos = false,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
      })
    end
  },
}
