-- genearl vim configuration goes here

-- use 2 spaces for tab
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.cmd("set number")

vim.g.mapleader = ","
-- common bindings
vim.keymap.set('n', '<leader>w', ':w<CR>') -- <leader> + w to write
vim.keymap.set('i', 'jj', '<Esc>') -- jj to escape

