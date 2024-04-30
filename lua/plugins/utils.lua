return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
  {
    'voldikss/vim-floaterm',
    config = function ()
      vim.keymap.set('n', '<leader>t', ':FloatermToggle<CR>')
    end
  }
}
