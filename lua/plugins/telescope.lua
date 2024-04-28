-- fuzzy finder
return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', builtin.find_files, {}) -- ctrl + p, search for files, ctrl + c to exit
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- another option
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- search for text in files
      vim.keymap.set('n', '<C-g>', builtin.live_grep, {}) -- another option
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
  }
}
