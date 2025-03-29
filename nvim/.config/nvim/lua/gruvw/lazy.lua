-- ~/.config/nvim/lua/gruvw/lazy.lua

-- lazy.nvim install, https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initializes lazy.nvim
-- Plugins loading from plugins directory, https://lazy.folke.io/usage/structuring
require("lazy").setup({
  spec = {
    { import = "gruvw.plugins" },
  },
  dev = {
    path = "/home/gruvw/SynologyDrive/Programmation/Lua/neovim",
  },
  ui = {
    border = "single",
    backdrop = 100,
  },
  change_detection = {
    enabled = false,
    notifiy = false,
  },
  -- Only enable when debugging lazy.nvim
  -- profiling = {
  --   require = false,
  -- },
})
