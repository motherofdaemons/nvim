local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  config = function()
    local harpoon = require("harpoon")

    local wk = require("which-key");

    wk.register({
      h = {
        name = '+Harpoon',
        a = { function() harpoon:list():append() end, "Append" },
        e = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Edit List" },
        h = { function() harpoon:list():select(1) end, "Slot 1" },
        j = { function() harpoon:list():select(2) end, "Slot 2" },
        k = { function() harpoon:list():select(3) end, "Slot 3" },
        l = { function() harpoon:list():select(4) end, "Slot 4" },
        p = { function() harpoon:list():prev() end, "Prev" },
        n = { function() harpoon:list():next() end, "Next" },
      },
    }, { prefix = '<leader>' })
  end,
}

return M
