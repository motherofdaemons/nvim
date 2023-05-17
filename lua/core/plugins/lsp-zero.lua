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

    -- Linting
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",

    -- Extra dependencies
    "simrat39/rust-tools.nvim",
    "Saecki/crates.nvim",
  }
}

function M.config()
  local lsp = require("lsp-zero")
  lsp.preset("recommended")

  lsp.ensure_installed({
    "lua_ls",
    "rust_analyzer",
    "clangd",
  })

  -- don't initialize this language server
  -- we will use rust-tools to setup rust_analyzer
  lsp.skip_server_setup({ 'rust_analyzer' })

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
  require("crates").setup()


  -- Setup null-ls
  require("null-ls").setup()
  require("mason-null-ls").setup({
    automatic_setup = true,
  })


  -- autocmd to format on save
  -- this should only format if we have an lsp that tells us how to format
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function() vim.lsp.buf.format() end,
  })
end

return M
