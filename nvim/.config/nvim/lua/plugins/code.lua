-- ~/.config/nvim/lua/plugins/code.lua

return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
      })
    end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        mode = "topline",
        max_lines = 4,
      })
    end,
  },

  -- TODO lazy loading

  -- https://github.com/VonHeikemen/lsp-zero.nvim
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "dev-v3",
    -- event = "VeryLazy",
    config = function()
      local lsp = require("lsp-zero").preset({})

      -- lsp.on_attach(function(client, bufnr)
      --   lsp.default_keymaps({buffer = bufnr})
      -- end)

      lsp.ensure_installed({
        "pyright",
        "rust_analyzer",
        "marksman",
        "texlab",
        "lua_ls",
        "emmet_language_server",
      })

      lsp.set_sign_icons({
        error = "E",
        warn =  "W",
        hint =  "H",
        info =  "I",
      })

      lsp.extend_cmp()
      lsp.setup()
    end
  },

  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- https://github.com/hrsh7th/cmp-nvim-lsp
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
       require("lspconfig.ui.windows").default_options.border = "rounded"
    end
  },

  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- https://github.com/L3MON4D3/LuaSnip
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-CR>"] = cmp.mapping.confirm({select = true}),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      -- https://github.com/williamboman/mason.nvim
      "williamboman/mason.nvim",
    },
    config = function()
      local lsp = require("lsp-zero")

      require("mason").setup({
        ui = {
          border = "rounded",
          height = 0.7,
        },
      })

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "pyright",
          "rust_analyzer",
          "marksman",
          "texlab",
          "lua_ls",
          "emmet_language_server",
        },
        handlers = {
          lsp.default_setup,
          lua_ls = function()
            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
          end,
        },
      })
    end
  },
}
