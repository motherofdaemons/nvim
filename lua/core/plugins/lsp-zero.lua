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

  -- get stuff setup to work with neovim functions
  lsp.nvim_workspace()

  -- save off rust_analyzer to use it with rust-tools
  local rust_lsp = lsp.build_options("rust_analyzer", {})

  -- change the default key mappings
  local cmp = require("cmp")

  local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
  })

  -- disable tab completion
  cmp_mappings["<Tab>"] = nil
  cmp_mappings["<S-Tab>"] = nil

  -- disable enter to confirm
  cmp_mappings["<CR>"] = nil

  lsp.setup_nvim_cmp({
    mapping = cmp_mappings
  })

  lsp.setup()

  -- Initialize rust_analyzer with rust-tools
  require("rust-tools").setup({ server = rust_lsp })

  -- autocmd to format on save
  -- this should only format if we have an lsp that tells us how to format
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function() vim.lsp.buf.format() end,
  })
end

return M
