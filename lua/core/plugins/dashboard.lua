local M = {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { { 'kyazdani42/nvim-web-devicons' } }
}

function M.config()
  require('dashboard').setup({})
end

return M
