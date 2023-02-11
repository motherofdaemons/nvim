local M = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
}

function M.config()
  require("nvim-tree").setup()
end

return M
