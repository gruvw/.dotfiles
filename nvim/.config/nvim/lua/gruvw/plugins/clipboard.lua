-- ~/.config/nvim/lua/gruvw/plugins/clipboard.lua

return {
  {
    -- https://github.com/AckslD/nvim-neoclip.lua
    "AckslD/nvim-neoclip.lua",
    event = "VeryLazy",
    dependencies = {
      -- https://github.com/kkharji/sqlite.lua
      "kkharji/sqlite.lua",

      "telescope.nvim",
    },
    config = function()
      -- nix eval --raw --impure --expr 'with import <nixpkgs> {}; "${sqlite.out}/lib/libsqlite3${stdenv.hostPlatform.extensions.sharedLibrary}"'
      vim.g.sqlite_clib_path = "/nix/store/0vpj29gvvl1z9fjwh4lk9fiyvkqf21px-sqlite-3.50.4/lib/libsqlite3.so"

      require("neoclip").setup({
        history = 1000,
        enable_persistent_history = true,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        preview = true,
        default_register = [["]],
        default_register_macros = [[j]],
        enable_macro_history = true,
        keys = {
          telescope = {
            i = {
              select = "<cr>",
            },
            n = {
              select = "<cr>",
              paste = "p",
              paste_behind = "P",
              delete = "d",
            },
          },
        },
      })
    end,
  },
}
