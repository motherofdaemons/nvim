local M = {
  "weilbith/nvim-code-action-menu",
}

function M.config()
  vim.api.nvim_set_keymap("n", "<c-m>", ":CodeActionMenu<CR>", {})
end

return M
