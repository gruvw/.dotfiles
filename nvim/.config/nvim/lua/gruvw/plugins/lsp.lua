-- ~/.config/nvim/lua/gruvw/plugins/lsp.lua

return {
  {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-cmp",
      -- "mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

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
    -- TODO use blink.cmp
    -- https://github.com/hrsh7th/nvim-cmp
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- https://github.com/hrsh7th/cmp-path
      "hrsh7th/cmp-path",

      -- https://github.com/saadparwaiz1/cmp_luasnip
      "saadparwaiz1/cmp_luasnip",

      -- https://github.com/hrsh7th/cmp-nvim-lsp
      "hrsh7th/cmp-nvim-lsp",

      "LuaSnip",
    },
    lazy = true,
    config = function()
      local cmp = require("cmp")
      local types = require("cmp.types")

      local border = cmp.config.window.bordered({ border = "single" })
      local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

      local ELLIPSIS = "..."

      cmp.setup({
        completion = {
          -- autocomplete = false,
          completeopt = "menu,menuone,noinsert", -- pre-select first option
        },
        mapping = {
          -- Completion results choice
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-c>"] = cmp.mapping.abort(),

          -- Move in completion results
          ["<Down>"] = { i = cmp.mapping.select_next_item(cmp_select_opts) },
          ["<Up>"] = { i = cmp.mapping.select_prev_item(cmp_select_opts) },

          -- Scroll up and down in the completion documentation
          ["<C-j>"] = cmp.mapping.scroll_docs(-5),
          ["<C-k>"] = cmp.mapping.scroll_docs(5),
        },
        window = {
          completion = border,
          documentation = border,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { "abbr", "menu", "kind" },
          format = function(entry, item)
            local win_width = vim.api.nvim_win_get_width(0)
            local max_label_width = math.max(10, math.min(50, win_width - 40))

            local short_name = {
              nvim_lsp = "LSP",
              nvim_lua = "NVIM",
              luasnip = "SNIP",
              path = "PATH",
            }

            local menu_name = short_name[entry.source.name] or entry.source.name
            item.menu = string.format("[%s]", menu_name)

            -- https://github.com/hrsh7th/nvim-cmp/issues/88 & https://github.com/hrsh7th/nvim-cmp/discussions/609#discussioncomment-3395522
            if #item.abbr > max_label_width then
              item.abbr = string.sub(item.abbr, 1, max_label_width) .. ELLIPSIS
            end

            return item
          end,
        },
      })
    end,
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
