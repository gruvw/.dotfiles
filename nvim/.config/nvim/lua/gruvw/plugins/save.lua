-- ~/.config/nvim/lua/gruvw/plugins/save.lua

return {
  {
    -- https://github.com/okuuva/auto-save.nvim
    "okuuva/auto-save.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("auto-save").setup({
        enabled = true,
        trigger_events = {
          immediate_save = { "BufLeave", "FocusLost", },
          defer_save = { "InsertLeave", "TextChanged", },
          cancel_deferred_save = { "ModeChanged", },
        },
        debounce_delay = 6000, -- time till a deferred save actually happens (if not cancelled)
        condition = function(buf)
          -- Ignore auto-save
          local ignore_buftype = {}
          local ignore_filetype = {}

          return not (vim.tbl_contains(ignore_buftype, vim.bo.buftype) or vim.tbl_contains(ignore_filetype, vim.bo.filetype))
        end,
      })

      -- auto-save execution message function
      -- local autosave_group = vim.api.nvim_create_augroup("autosave", {})
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "AutoSaveWritePost",
      --   group = autosave_group,
      --   callback = function(opts)
      --     if opts.data.saved_buffer ~= nil then
      --       vim.notify("saved " .. vim.fn.strftime("%H:%M:%S"), vim.log.levels.INFO)
      --     end
      --   end,
      -- })
    end,
  },
}
