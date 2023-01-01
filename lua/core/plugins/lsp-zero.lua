local M = {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    -- LSP Support
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  }
}

function M.config()
  local lsp = require("lsp-zero")
  lsp.preset("recommended")

  lsp.ensure_installed({
    "sumneko_lua",
    "rust_analyzer",
    "clangd",
  })

  local rust_lsp = lsp.build_options("rust_analyzer", {})

  lsp.nvim_workspace()
  lsp.setup()

  -- Initialize rust_analyzer with rust-tools
  require('rust-tools').setup({ server = rust_lsp })
end

return M
