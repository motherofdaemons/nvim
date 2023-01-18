local M = {
  "folke/which-key.nvim",
}

function M.config()
  vim.o.timeoutlen = 300
  require("which-key").setup({
  })
end

return M
