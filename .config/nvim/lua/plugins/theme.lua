-- Soho vibes for Neovim
-- https://github.com/rose-pine/neovim

return {
	'rose-pine/neovim',
	name = 'rose-pine',
	lazy = false,
	priority = 1000,
	config = function()
		require('rose-pine').setup({
			variant = 'main',
			styles = {
				italic = false,
				transparency = true,
			},
			highlight_groups = {
				Visual = { fg = 'base', bg = 'love', inherit = false },
			},
		})
		vim.cmd('colorscheme rose-pine')
	end,
}
