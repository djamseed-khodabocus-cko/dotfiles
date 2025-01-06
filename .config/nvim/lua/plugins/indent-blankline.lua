-- Indentation guides
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	event = { 'BufReadPost', 'BufNewFile' },
	config = function()
		require('ibl').setup({
			exclude = {
				filetypes = {
					'help',
					'alpha',
					'neo-tree',
					'Trouble',
					'lazy',
					'mason',
					'notify',
				},
			},
			indent = {
				char = '.',
				highlight = { 'LineNr' },
			},
			scope = {
				enabled = false,
			},
		})
	end,
}
