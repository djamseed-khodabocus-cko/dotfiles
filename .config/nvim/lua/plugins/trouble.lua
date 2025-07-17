-- Pretty list for showing diagnostics
-- https://github.com/folke/trouble.nvim

return {
	'folke/trouble.nvim',
	event = 'VeryLazy',
	opts = {},
	keys = {
		{ '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
		{ '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
		{ '<leader>xp', '<cmd>Trouble  diagnostics prev<cr>', desc = 'Diagnostics: Jump to previous item (Trouble)' },
		{ '<leader>xn', '<cmd>Trouble  diagnostics next<cr>', desc = 'Diagnostics: Jump to next item (Trouble)' },
		{ '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
		{ '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
	},
}
