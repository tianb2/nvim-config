-- use 2 spaces for tab
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- other common settings
vim.cmd("set number")
vim.g.mapleader = " "

-- install plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- setup lazy.nvim
local plugins = {
  -- colorscheme
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        -- Your config here
        background = "hard"
      })
    end,
  },
  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- tree-sitter for the parsers
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  -- good old nerdtree for the file system
  'preservim/nerdtree',
  -- good old fugitive for git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb', -- for :GB
  -- for comments
  'tpope/vim-commentary',
  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  -- mason for managing lsp, dap, linters, formatters
  -- and also mason-lspconfig that bridges mason with the lspconfig plugin
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
}
local opts = {}

require("lazy").setup(plugins, opts)

-- set colorscheme
require("everforest").load()

-- setup telescope for fuzzy search
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {}) -- ctrl + p, search for files, ctrl + c to exit
vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- another option
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- search for text in files
vim.keymap.set('n', '<C-g>', builtin.live_grep, {}) -- another option
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- common bindings
vim.keymap.set('n', '<leader>w', ':w<CR>') -- <leader> + w to write

-- setup treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}

-- setup nerdtree
vim.keymap.set('n', '<C-k><C-n>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<C-k><C-e>', ':NERDTreeFind<CR>')

-- setup lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {
        'nerdtree' -- disable in the nerdtree buffer
      },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- setup mason
require("mason").setup()

-- mason lspconfig
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer" },
}

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
