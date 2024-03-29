-- ~/.config/nvim/lua/gruvw/lsp/arduino_language_server.lua

return {
  cmd = {
    "arduino-language-server",
    "-cli-config", "/home/gruvw/.arduinoIDE/arduino-cli.yaml",
    "-cli", "/home/gruvw/Applications/Arduino/bin/arduino-cli",
    "-clangd", "clangd",
    "-format-conf-path", "/home/gruvw/.clang-format",
    "-fqbn",
    "arduino:avr:uno",
  },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          deprecatedSupport = true,
          snippetSupport = true,
        },
      },
    },
  },
}
