-- ~/.config/nvim/after/ftplugin/java.lua

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- https://github.com/eclipse-jdtls/eclipse.jdt.ls#installation
    "-jar", "/home/gruvw/libs/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration", "/home/gruvw/libs/jdtls/config_linux",

    "-data", "/home/gruvw/.local/share/nvim/jdtls-data/" .. project_name,
  },

  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "src", }),

  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      format = {
        enabled = true,
        settings = {
          url = "https://raw.githubusercontent.com/gruvw/.dotfiles/main/others/java/java-style-rules.xml",
        }
      },
    }
  },

  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  init_options = {
    bundles = {}
  },
}

require("jdtls").start_or_attach(config)
