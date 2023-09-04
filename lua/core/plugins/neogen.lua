local M = {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    require("neogen").setup({ snippet_engine = "luasnip" })
    local wk = require("which-key")
    wk.register({
      d = {
        name = "Documentation",
        g = { ":lua require('neogen').generate()<CR>", "Generate" },
      },
    }, { prefix = "<leader>" })
  end,
}

return M
