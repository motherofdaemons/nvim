local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- LSP Support
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

    -- Debug
    "mfussenegger/nvim-dap",

    -- Extra dependencies
    {
      'mrcjkb/rustaceanvim',
      version = '^3', -- Recommended
      ft = { 'rust' },
    },
    "Saecki/crates.nvim",
    { "folke/neodev.nvim", opts = {} },
    {
      "lvimuser/lsp-inlayhints.nvim",
      opts = {}
    },
  },
  config = function()
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf }

        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      end
    })

    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local default_setup = function(server)
      require('lspconfig')[server].setup({
        capabilities = lsp_capabilities,
      })
    end

    require('mason').setup({})
    require("mason-lspconfig").setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:
      ["rust_analyzer"] = function()
        vim.g.rustaceanvim = {
          -- Plugin configuration
          tools = {
          },
          -- LSP configuration
          server = {
            on_attach = function(client, bufnr)
              require("lsp-inlayhints").on_attach(client, bufnr)
            end,
            settings = {
              -- rust-analyzer language server configuration
              ['rust-analyzer'] = {
                checkOnSave = {
                  enable = true,
                  command = "clippy",
                },
                cargo = {
                  allFeatures = true,
                },
              },
            },
          },
          -- DAP configuration
          dap = {
          },
        }
      end
    }

    -- allow me to move through snippets using ctrl j and l
    local ls = require("luasnip")
    vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

    local cmp = require('cmp')

    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
      },
      mapping = cmp.mapping.preset.insert({
        -- Enter key confirms completion item
        ['<C-y>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl + space triggers completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    })



    -- autocmd to format on save
    -- this should only format if we have an lsp that tells us how to format
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      callback = function() vim.lsp.buf.format() end,
    })
  end,
}

return M
