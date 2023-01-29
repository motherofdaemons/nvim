local M = {
  "folke/trouble.nvim",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  lazy = false,
}

function M.config()
  require("trouble").setup {}
  local wk = require("which-key")
  wk.register({
    x = {
      name = "Trouble",
      x = { "<cmd>TroubleToggle<cr>", "Trouble toggle" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    },
  }, { prefix = "<leader>" })
end

return M
