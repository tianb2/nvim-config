-- use 2 spaces for tab
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
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
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
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
