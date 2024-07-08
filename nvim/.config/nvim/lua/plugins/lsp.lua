-- ~/.config/nvim/lua/plugins/lsp.lua

-- Set sign icons, from lsp-zero: https://github.com/VonHeikemen/lsp-zero.nvim/blob/f084f4a6a716f55bf9c4026e73027bb24a0325a3/lua/lsp-zero/server.lua#L169
local function set_sign_icons(opts)
  opts = opts or {}

  local sign = function(args)
    if opts[args.name] == nil then
      return
    end

    vim.fn.sign_define(args.hl, {
      texthl = args.hl,
      text = opts[args.name],
      numhl = ""
    })
  end

  sign({ name = "error", hl = "DiagnosticSignError", })
  sign({ name = "warn", hl = "DiagnosticSignWarn", })
  sign({ name = "hint", hl = "DiagnosticSignHint", })
  sign({ name = "info", hl = "DiagnosticSignInfo", })
end

return {
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-cmp",
      "mason-lspconfig.nvim",
      "lsp_lines.nvim",
    },
    event = "VeryLazy",
    -- lazy = true,
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)
      lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Add border to LSP windows
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "single", }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "single", }
      )
      require("lspconfig.ui.windows").default_options.border = "single"

      -- LSP commands
      local command = vim.api.nvim_create_user_command
      command(
        "LspWorkspaceAdd",
        function() vim.lsp.buf.add_workspace_folder() end,
        { desc = "Add folder to workspace", }
      )
      command(
        "LspWorkspaceList",
        function() vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        { desc = "List workspace folders", }
      )
      command(
        "LspWorkspaceRemove",
        function() vim.lsp.buf.remove_workspace_folder() end,
        { desc = "Remove folder from workspace", }
      )

      -- Diagnostics config
      vim.diagnostic.config({
        underline = true,
        severity_sort = true, -- Sort diagnostics by severity
        float = { border = "single", },
        virtual_text = true, -- Use lsp_lines
        virtual_lines = false,
      })

      -- Set sign icons in gutter
      set_sign_icons({
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
      })

      require("lspconfig").clangd.setup({
        capabilities = lsp_defaults.capabilities,
      })
      require("lspconfig").cssls.setup({
        capabilities = lsp_defaults.capabilities,
      })

      -- Start LSP
      vim.cmd(":LspStart")
    end
  },

  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      -- https://github.com/williamboman/mason.nvim
      "williamboman/mason.nvim",

      -- https://github.com/jay-babu/mason-nvim-dap.nvim
      "jay-babu/mason-nvim-dap.nvim",

      -- https://github.com/mfussenegger/nvim-jdtls
      "mfussenegger/nvim-jdtls",
    },
    lazy = true,
    config = function()
      require("mason").setup({
        ui = {
          border = "single",
          height = 0.7,
        },
      })

      require("mason-nvim-dap").setup({
        -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
        ensure_installed = {
          "cppdbg",
        },
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      local function default_setup(server)
        require("lspconfig")[server].setup({})
      end

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "pyright",
          "rust_analyzer",
          "marksman",
          "texlab",
          "lua_ls",
          "cssls",
          "emmet_language_server",
          "html",
          "clangd",
          "jsonls",
          "arduino_language_server",
          "tailwindcss",
        },
        handlers = {
          default_setup,
          lua_ls = function() require("lspconfig").lua_ls.setup(require("gruvw.lsp.lua_ls")) end,
          html = function() require("lspconfig").html.setup(require("gruvw.lsp.html")) end,
          arduino_language_server = function() require("lspconfig").arduino_language_server.setup(require("gruvw.lsp.arduino_language_server")) end,
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

  -- https://git.sr.ht/~whynothugo/lsp_lines.nvim
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    enabled = true,
    lazy = true,
    config = function()
      require("lsp_lines").setup()
    end
  },

  -- https://github.com/mfussenegger/nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- https://github.com/rcarriga/nvim-dap-ui
      "rcarriga/nvim-dap-ui",

      "overseer.nvim",
    },
    lazy = true,
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Signs
      vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "Error", })
      vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "Error", })
      vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "", })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "Error", })
      vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "Error", })

      require("overseer").patch_dap(true)
      require("dap.ext.vscode").json_decode = require("overseer.json").decode

      dapui.setup({
        controls = {
          enabled = false,
        },
      })

      -- Open close automagically
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- https://github.com/L3MON4D3/LuaSnip
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      -- https://github.com/rafamadriz/friendly-snippets
      "rafamadriz/friendly-snippets",

      "nvim-treesitter",
    },
    build = "make install_jsregexp",
    event = "VeryLazy",
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")

      ls.setup({
        history = true,
        enable_autosnippets = true,
        update_events = { "TextChanged", "TextChangedI" },
        store_selection_keys = "<Tab>", -- use key on selection for $TM_SELECTED_TEXT content
        ext_opts = {
          [types.insertNode] = {
            unvisited = { hl_group = "LuaSnipPlace" },
          },
          [types.exitNode] = {
            unvisited = { hl_group = "LuaSnipPlace" },
          },
        }
      })

      -- Load user snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/gruvw/snippets/lua" })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/lua/gruvw/snippets/lsp" })

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load({
        exclude = { "plaintex", "all", "tex" },
      })

      -- Filetype fixes
      ls.filetype_extend("plaintex", { "tex" })
      ls.filetype_extend("dart", { "flutter" })
    end,
  },

  -- https://github.com/akinsho/flutter-tools.nvim
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "plenary.nvim",
      -- "dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "single",
          notification_style = "native",
        },
        debugger = {
          enabled = false,
          run_via_dap = false,
        },
        lsp = {
          settings = {
            showTodos = false,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
      })
    end
  },

  -- https://github.com/github/copilot.vim
  {
    "github/copilot.vim",
    keys = { { "<leader>Ce", ":Copilot enable<CR>" } },
    config = function()
      vim.g.copilot_no_tab_map = true
    end
  }
}
