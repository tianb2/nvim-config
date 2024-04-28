-- configure tools such as formatter that is not lsp
return {
	{
		"jay-babu/mason-null-ls.nvim", -- package list for none-ls.nvim
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "stylua", "prettier", "eslint_d", "black", "isort" },
				-- ensure_installed = nil,
				-- automatic_installation = true,
			})

			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.diagnostics.eslint_d,
          require('none-ls.diagnostics.eslint_d'), -- has been removed from builtins
					-- null_ls.builtins.completion.spell,
					-- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
					-- "diagnostics" means linting by the way
					null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.diagnostics.rubocop,
					-- null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
				},
			})
		end,
	},
}
