local M = {
  "akinsho/toggleterm.nvim",
}

function M.config()
  require("toggleterm").setup({
    open_mapping = [[<c-t>]],
    terminal_mappings = true,
  })
end

return M
