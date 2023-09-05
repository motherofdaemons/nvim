local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust",
  },
  config = function()
    local wk = require("which-key")
    wk.register({
      t = {
        name = "Test",
        r = {
          name = "Run",
          t = { function() require("neotest").run.run() end, "Run test" },
          f = { function() require("neotest").run.run(vim.fn.expand("%")) end, "Run file" },
        },
        o = {
          name = "Open",
          o = { function() require("neotest").output.open({ enter = true }) end, "Open output" },
        },
      },
      prefix = "<leader>"
    })

    require("neotest").setup({
      adapters = {
        require("neotest-rust")
      }
    })
  end
}

return M
