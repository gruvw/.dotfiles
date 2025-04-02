-- ~/.config/nvim/lua/gruvw/plugins/statusline.lua

-- Lualine components

-- Vim mode
local mode_map = {
  ["NORMAL"] = "N",
  ["O-PENDING"] = "OP",
  ["INSERT"] = "I",
  ["VISUAL"] = "V",
  ["V-BLOCK"] = "VB",
  ["V-LINE"] = "VL",
  ["V-REPLACE"] = "VR",
  ["REPLACE"] = "R",
  ["COMMAND"] = "C",
  ["SHELL"] = "SH",
  ["TERMINAL"] = "T",
  ["EX"] = "X",
  ["S-BLOCK"] = "SB",
  ["S-LINE"] = "SL",
  ["SELECT"] = "S",
  ["CONFIRM"] = "Y?",
  ["MORE"] = "M",
}
local mode_cmpnt = {
  "mode",
  fmt = function(s)
    return mode_map[s] or s
  end,
}

-- File type, LSP, spell check, overseer
local filetype_cmpnt = {
  "filetype",
  icon = { align = "left", },
  fmt = function(s)
    -- LSP
    -- Show "+" if LSP client is running, "~" when progress
    local lsp = ""
    if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
      local progress = require("lsp-progress").progress({
        format = function(messages)
          return #messages > 0
        end,
      })

      lsp = progress and "~" or "+"
    end

    -- Spell check
    local spell = ""
    if vim.o.spell then
      spell = "s"
    end

    -- Overseer status
    local tasks = require("overseer.task_list").list_tasks({ unique = true, })
    local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
    local status = ""
    if tasks_by_status["RUNNING"] then
      status = " R"
    elseif tasks_by_status["FAILURE"] then
      status = " F"
    elseif tasks_by_status["SUCCESS"] then
      status = " S"
    end

    -- Copilot
    local copilot = ""
    if vim.g.copilot_enabled == 1 then
      copilot = "*"
    end

    return spell .. lsp .. copilot .. status
  end,
}

-- File name
local filename_cmpnt = {
  "filename",
  symbols = {
    modified = "+",
    readonly = "-",
    unnamed = "[No Name]",
    newfile = "[New]",
  },
}

-- Progress rename strings
local progress_map = {
  ["Top"] = "top",
  ["Bot"] = "btm",
}
local progress_cmpnt = {
  "progress",
  fmt = function(s)
    return progress_map[s] or s
  end,
}


return {
  {
    -- https://github.com/nvim-lualine/lualine.nvim
    "nvim-lualine/lualine.nvim",
    dependencies = {
      -- https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons", -- icons support

      -- https://github.com/linrongbin16/lsp-progress.nvim
      "linrongbin16/lsp-progress.nvim",

      "overseer.nvim",
    },
    config = function()
      require("lsp-progress").setup()

      require("lualine").setup({
        options = {
          theme = "chromance",
          globalstatus = true,
          icons_enabled = true,
          section_separators = { left = "", right = "", },
          component_separators = { left = "|", right = "|", },
          refresh = {
            statusline = 500,
            tabline = 500,
            winbar = 500,
          }
        },
        extensions = {
          "trouble",
          "fugitive",
          "lazy",
          "man",
          "mason",
          "nvim-dap-ui",
          "overseer",
        },
        sections = {
          lualine_a = { mode_cmpnt, },
          lualine_b = { "branch", },
          lualine_c = { filename_cmpnt, "diff", },
          lualine_x = { "diagnostics", filetype_cmpnt, },
          lualine_y = { progress_cmpnt, },
          lualine_z = { "location", },
        },
      })
    end
  },
}
