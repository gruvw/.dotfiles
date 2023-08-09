-- ~/.config/nvim/lua/plugins/files.lua

return {
  -- https://github.com/okuuva/auto-save.nvim
  {
    "okuuva/auto-save.nvim",
    opts = {
      enabled = true,
      execution_message = {
        message = function()
          return "saved"
        end,
      },
      cleaning_interval = 1500,
      debounce_delay = 5000, -- time till a defered save acctually happens (if not cancelled)
    },
  },
}
