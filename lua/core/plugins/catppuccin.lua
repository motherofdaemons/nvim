local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- make sure we always load our color scheme
    priority = 9999, -- make sure our colorscheme is set first
}

function M.config()
  -- configure catppuccin
  require("catppuccin").setup({ flavour = "frappe" })
  -- set our colorscheme
  vim.cmd [[colorscheme catppuccin]]
end

return M
