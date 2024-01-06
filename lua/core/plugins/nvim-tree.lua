local M = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  opts = {},
  config = function()
    require('nvim-tree').setup()
    local wk = require('which-key')
    wk.register({
      e = { '<cmd>NvimTreeFindFileToggle<cr>', 'File Tree' },
    }, { prefix = '<leader>' })
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
          vim.cmd "quit"
        end
      end
    })
  end,
}


return M
