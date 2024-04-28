-- good old nerdtree for the file system
return {
  {
    'preservim/nerdtree',
    config = function()
      -- setup nerdtree
      vim.keymap.set('n', '<C-k><C-n>', ':NERDTreeToggle<CR>')
      vim.keymap.set('n', '<C-k><C-e>', ':NERDTreeFind<CR>')
    end
  }
}
