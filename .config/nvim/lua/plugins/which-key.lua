-- Remember keymaps by displaying a popup with possible keybindings
-- https://github.com/folke/which-key.nvim

return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	opts = {
		delay = 0,
		icons = {
			mappings = vim.g.have_nerd_font,
			keys = {},
		},
		spec = {
			{ '<leader>B', group = 'Breakpoint' },
			{ '<leader>c', group = 'Code', mode = { 'n', 'x' } },
			{ '<leader>d', group = 'Document' },
			{ '<leader>s', group = 'Search' },
			{ '<leader>g', group = 'Git' },
			{ '<leader>m', group = 'Mark' },
			{ '<leader>r', group = 'Code' },
			{ '<leader>t', group = 'Diagnostics' },
		},
	},
}
