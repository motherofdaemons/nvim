local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "mrjones2014/nvim-ts-rainbow",
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
}

return M
