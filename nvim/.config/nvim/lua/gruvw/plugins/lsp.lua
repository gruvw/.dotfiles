-- ~/.config/nvim/lua/gruvw/plugins/lsp.lua

return {
  {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "blink.cmp",
      -- "mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "single" }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "single" }
      )

      -- require("lspconfig.ui.windows").default_options.border = "single"

      -- Diagnostics config (unrelated to lspconfig, unchanged)
      vim.diagnostic.config({
        underline = true,
        severity_sort = true,
        float = { border = "single" },
        -- TODO change to new lsp_lines system
        virtual_text = true,
        virtual_lines = false,
      })

      vim.lsp.config("tinymist", {
        single_file_support = true,
        settings = {
          exportPdf = "onSave",
        },
      })

      vim.lsp.enable({
        "clangd",
        "cssls",
        "tinymist",
        "pyright",
        "rust_analyzer",
        "ts_ls",
      })
    end
  },

  {
    -- https://github.com/saghen/blink.cmp
    "saghen/blink.cmp",
    version = "1.*",
    lazy = true,
    dependencies = {
      -- https://github.com/L3MON4D3/LuaSnip
      "LuaSnip",
    },
    opts = {
      keymap = {
        preset = "none",
        ["<C-Space>"] = { "show" },
        ["<C-CR>"] = { "select_and_accept" },
        ["<C-c>"] = { "cancel" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "scroll_documentation_down", "fallback" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
      },
      snippets = { preset = "luasnip" },
      completion = {
        menu = {
          border = "single",
          draw = {
            cursorline_priority = 0, -- highlighting related
            columns = {
              { "label", gap = 1 },
              { "kind", "source_name", gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = { border = "single" },
        },
      },
      sources = {
        default = { "lsp", "snippets", "path" },
      },
    },
  },

  {
    -- https://github.com/folke/trouble.nvim
    "folke/trouble.nvim",
    lazy = true,
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        fold_open = "v",
        fold_closed = ">",
        indent_lines = false,
        focus = true,
        multiline = false,
        restore = true,
        warn_no_results = false,
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        win_config = { border = "single", },
        modes = {
          diagnostics = {
            groups = {
              { "filename", format = "{file_icon} {basename:Title} {count}" },
            },
          },
          -- only show diagnostics for files in current workspace
          workspace_diagnostics = {
            mode = "diagnostics",
            filter = function(items)
              return vim.tbl_filter(function(item)
                return item.filename:find(vim.fn.getcwd(), 1, true)
              end, items)
            end,
          }
        },
        signs = {
          error = "E",
          warning = "W",
          hint = "H",
          information = "I",
          other = "?",
        },
        action_keys = {
          close = { "q", "Zq", },
          cancel = "<Esc>",             -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r",                -- manually refresh
          jump = "<CR>",                -- jump to the diagnostic or open / close folds
          open_split = "<c-x>",         -- open buffer in new split
          open_vsplit = "<c-v>",        -- open buffer in new vsplit
          open_tab = "<c-t>",           -- open buffer in new tab
          jump_close = "<BS>",          -- jump to the diagnostic and close the list
          toggle_mode = "<Tab>",        -- toggle between "workspace" and "document" diagnostics mode
          switch_severity = "s",        -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
          toggle_preview = "P",         -- toggle auto_preview
          hover = "K",                  -- opens a small popup with the full multiline message
          preview = "p",                -- preview the diagnostic location
          open_code_href = "gx",        -- if present, open a URI with more information about the diagnostic error
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" },  -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k",               -- previous item
          next = "j",                   -- next item
          help = "?",                   -- help menu
        },
        icons = {
          indent        = {
            top         = "│ ",
            middle      = "├╴",
            last        = "└╴",
            fold_open   = " ",
            fold_closed = " ",
            ws          = "  ",
          },
          folder_closed = " ",
          folder_open   = " ",
          kinds         = {
            Array         = " ",
            Boolean       = "󰨙 ",
            Class         = " ",
            Constant      = "󰏿 ",
            Constructor   = " ",
            Enum          = " ",
            EnumMember    = " ",
            Event         = " ",
            Field         = " ",
            File          = " ",
            Function      = "󰊕 ",
            Interface     = " ",
            Key           = " ",
            Method        = "󰊕 ",
            Module        = " ",
            Namespace     = "󰦮 ",
            Null          = " ",
            Number        = "󰎠 ",
            Object        = " ",
            Operator      = " ",
            Package       = " ",
            Property      = " ",
            String        = " ",
            Struct        = "󰆼 ",
            TypeParameter = " ",
            Variable      = "󰀫 ",
          },
        },
      })
    end
  },
}
