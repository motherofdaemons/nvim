local M = {
  "weilbith/nvim-code-action-menu",
}

function M.config()
  vim.g.code_action_menu_window_border = "rounded"
  local wk = require("which-key")
  wk.register({
    c = {
      name = "Code",
      a = { "<cmd>CodeActionMenu<cr>", "Action Menu" },
    },
  }, { prefix = "<leader>" })
end

return M
