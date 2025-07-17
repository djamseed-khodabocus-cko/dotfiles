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
		image = { enabled = true, force = true },
		indent = {
			enabled = true,
			char = '.',
			only_current = true,
		},
		notifier = { enabled = true, timeout = 5000 },
		quickfile = { enabled = true },
		words = { enabled = true },
	},
}
