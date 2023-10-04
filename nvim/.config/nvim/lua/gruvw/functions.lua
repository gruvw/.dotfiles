-- ~/.config/nvim/lua/gruvw/functions.lua

function system_open(path)
  vim.cmd([[silent exec "!nohup xdg-open ]] .. path .. [[ &>/dev/null &"]])
end

-- Insert current date in YYYY_MM_DD format, before cursor
function insert_date()
  local date_format = os.date("%Y_%m_%d")
  vim.api.nvim_put({ date_format }, "", false, true)
end

-- Run build / restart
function run_build()
  if vim.bo.filetype == "dart" then
    vim.cmd("FlutterRun")
  else
    require("overseer").run_template()
  end
end

function overseer_restart()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end

function overseer_term()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "open float")
  end
end

function run_restart()
  if vim.bo.filetype == "dart" then
    vim.cmd("FlutterRestart")
  else
    overseer_restart()
  end
end

-- Load local config
function local_config()
  -- Load exrc ".nvim.lua", secure
  local config = vim.fn.getcwd() .. "/.nvim.lua"
  local content = vim.secure.read(config)
  if content then
    vim.cmd([[source ]] .. config)
  end
end
