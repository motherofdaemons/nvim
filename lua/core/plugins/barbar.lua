local M = {
  'romgrk/barbar.nvim',
  dependencies = 'kyazdani42/nvim-web-devicons',
}

function M.config()
  local wk = require('which-key')
  wk.register({
    b = {
      name = '+Buffer',
      n = { '<cmd>BufferNext<cr>', 'Next' },
      p = { '<cmd>BufferPrevious<cr>', 'Previous' },
      q = { '<cmd>BufferClose<cr>', 'Close' },
    },
  }, { prefix = '<leader>' })
end

return M
