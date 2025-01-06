-- A collection of small QoL plugins for Neovim
-- https://github.com/folke/snacks.nvim

return {
	'folke/snacks.nvim',
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = 'header' },
				{ section = 'keys', gap = 1, padding = 1 },
				{ section = 'startup' },
			},
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
	},
}
