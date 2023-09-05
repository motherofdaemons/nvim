local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "mrjones2014/nvim-ts-rainbow",
    "nvim-treesitter/nvim-treesitter-context",
  },
  run = ":TSUpdate",
  opts = {
    ensure_installed = "all",
    auto_install = true,
    highlight = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
  },
  config = function()
    local wk = require("which-key")
    wk.register({
      ["["] = {
        c = { require("treesitter-context").go_to_context(), "Go to context" },
      },
    })
  end
}

return M
