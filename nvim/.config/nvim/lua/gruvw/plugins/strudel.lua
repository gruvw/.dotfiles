-- ~/.config/nvim/lua/gruvw/plugins/strudel.lua

return {
  {
    "strudel.nvim",
    dev = true,
    build = "npm ci",
    config = function()
      require("strudel").setup({
        ui = {
          hide_top_bar = true,
          maximise_menu_panel = true,
          hide_menu_panel = false,
          hide_code_editor = false,
          hide_error_display = true,
        },
        start_on_launch = true,
        update_on_save = false,
        cursor_sync = true,
        report_eval_errors = true,
        headless = false,
      })
    end
  },
  -- {
  --   "gruvw/strudel.nvim",
  --   build = "npm install",
  --   config = function()
  --     require("strudel").setup({
  --       ui = {
  --         hide_top_bar = true,
  --         maximise_menu_panel = true,
  --         hide_menu_panel = false,
  --         hide_code_editor = false,
  --         hide_error_display = true,
  --       },
  --       update_on_save = false,
  --       cursor_sync = true,
  --       report_eval_errors = true,
  --       headless = false,
  --     })
  --   end
  -- },
}
