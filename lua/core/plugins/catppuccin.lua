local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,    -- make sure we always load our color scheme
  priority = 9999, -- make sure our colorscheme is set first
  config = function()
    require("catppuccin").setup({ flavour = "frappe" })
    vim.cmd [[colorscheme catppuccin]]
  end,
}

return M
