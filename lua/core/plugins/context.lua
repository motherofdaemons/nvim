local M = {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = 'nvim-treesitter/nvim-treesitter'
}

function M.config()
  local context = require("treesitter-context")
  local wk = require('which-key')
  wk.register({
    ["["] = {
      c = { context.go_to_context, "Go up to context" }
    }
  })
end

return M
