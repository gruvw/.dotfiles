-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  -- https://github.com/VonHeikemen/lsp-zero.nvim
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "dev-v3",
    dependencies = {
      "nvim-lspconfig",
      "mason-lspconfig.nvim",
      "nvim-cmp",
    },
    event = "BufReadPre",
    config = function()
      local lsp = require("lsp-zero").preset({})

      lsp.set_sign_icons({
        error = "E",
        warn =  "W",
        hint =  "H",
        info =  "I",
      })

      -- Sort diagnostics by severity
      vim.diagnostic.config({
        severity_sort = true,
      })

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
    lazy = true,
    config = function()
      require("lspconfig.ui.windows").default_options.border = "single"
    end
  },

  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      -- https://github.com/williamboman/mason.nvim
      "williamboman/mason.nvim",
    },
    lazy = true,
    config = function()
      local lsp = require("lsp-zero")

      require("mason").setup({
        ui = {
          border = "single",
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

  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- https://github.com/hrsh7th/cmp-path
      "hrsh7th/cmp-path",

      "LuaSnip",
    },
    lazy = true,
    config = function()
      require("lsp-zero").extend_cmp()

      local cmp = require("cmp")

      cmp.setup({
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-CR>"] = cmp.mapping.confirm({select = true}),
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "single",
          }),
          documentation = cmp.config.window.bordered({
            border = "single",
          }),

        },
        sources = {
          {name = "nvim_lsp"},
          {name = "path"},
        },
      })
    end,
  },

  -- https://github.com/L3MON4D3/LuaSnip
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      -- Style for default placeholder text
      vim.api.nvim_set_hl(0, "LuaSnipPlace", {
        bg = "#363537",
        italic = true,
      })

      local types = require("luasnip.util.types")

      require("luasnip").setup({
        ext_opts = {
          [types.insertNode] = {
            unvisited = {
              hl_group = "LuaSnipPlace",
            },
          },
          [types.exitNode] = {
            unvisited = {
              hl_group = "LuaSnipPlace",
            },
          },
        }
      })

    end,
  },
}
