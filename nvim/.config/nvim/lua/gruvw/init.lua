-- ~/.config/nvim/lua/gruvw/init.lua

-- Set leader key to space, set before lazy plugins
vim.g.mapleader = " "

-- Load package manager and plugins
require("gruvw.lazy")

-- Load modules
require("gruvw.set")
require("gruvw.functions")
require("gruvw.remap")
require("gruvw.scripts")
