-- ~/.config/nvim/lua/gruvw/plugins/auto-save.lua

return {
  -- https://github.com/okuuva/auto-save.nvim
  "okuuva/auto-save.nvim",
  event = "VeryLazy",
  enabled = false,
  opts = {
    enabled = true,
    -- execution_message = {
    --   message = function()
    --     return "saved"
    --   end,
    -- },
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost", },
      defer_save = { "InsertLeave", "TextChanged", },
      cancel_deferred_save = { "ModeChanged", },
    },
    cleaning_interval = 3000,   -- time before erasing the execution msg
    debounce_delay = 6000,      -- time till a defered save acctually happens (if not cancelled)
    condition = function(buf)
      -- Ignore auto-save
      local ignore_buftype = {}
      local ignore_filetype = {}

      if vim.tbl_contains(ignore_buftype, vim.bo.buftype)
          or vim.tbl_contains(ignore_filetype, vim.bo.filetype)
      then
        return false
      end

      return true
    end,
  },
}
