return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', function()
				builtin.find_files({ hidden = true })
			end,
			{ desc = 'Telescope find files' }
		)
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git",
					"target",
					".next",
					".vscode",
				}
			}
		})
	end,
}
