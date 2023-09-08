-- ~/.config/nvim/lua/gruvw/overseer/python.lua

return {
      name = "t",
      builder = function(params)
    -- This must return an overseer.TaskDefinition
    return {
      -- cmd is the only required field
      cmd = {'echo'},
      -- additional arguments for the cmd
      args = {"hello", "world", "$PWD"},
      -- the name of the task (defaults to the cmd of the task)
      name = "Greet",
      -- additional environment variables
      env = {
        VAR = "FOO",
      },
    }
  end,
}
