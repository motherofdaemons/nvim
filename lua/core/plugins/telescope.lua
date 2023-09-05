local M = {
  "nvim-telescope/telescope.nvim",
  version = "0.1.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
  },
  config = function()
    -- keymaps for telescope
    local builtin = require("telescope.builtin")
    local wk = require("which-key")
    wk.register({
      f = {
        name = "File",
        F = { builtin.find_files, "Find Files" },
        f = { builtin.git_files, "Find Git Files" },
        o = { builtin.oldfiles, "Open Old Files" },
        g = { builtin.live_grep, "Live Grep" },
        b = { builtin.buffers, "Buffers" },
        n = { builtin.help_tags, "Help Tags" },
      },
    }, { prefix = "<leader>" })

    -- enable opening telescope results in trouble
    local trouble = require("trouble.providers.telescope")
    local telescope = require("telescope")
    telescope.setup {
      defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
      },
    }
  end
}

return M
