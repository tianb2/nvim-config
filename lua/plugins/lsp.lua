-- mason for managing lsp, dap, linters, formatters
-- and also mason-lspconfig that bridges mason with the lspconfig plugin
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {
          ensure_installed = { "lua_ls", "rust_analyzer" },
      }

    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- lspconfig
      local lspconfig = require('lspconfig')

      lspconfig.rust_analyzer.setup {
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
          ['rust-analyzer'] = {},
        },
      }
      lspconfig.lua_ls.setup({})

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
