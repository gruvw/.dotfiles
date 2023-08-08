-- ~/.config/nvim/lua/plugins/files.lua

return {
  -- https://github.com/okuuva/auto-save.nvim
  "okuuva/auto-save.nvim",
  opts = {
    enabled = false,
    execution_message = {
      message = function()
        return "saved"
      end,
    },
    cleaning_interval = nil,
  },
}
