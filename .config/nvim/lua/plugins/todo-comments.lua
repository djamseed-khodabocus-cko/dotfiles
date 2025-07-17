-- Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim

return {
	'folke/todo-comments.nvim',
	event = 'VeryLazy',
	keys = {
		{ '<leader>xt', '<cmd>Trouble todo<CR>', desc = 'Find todos', noremap = true, silent = true },
		{ '<leader>xT', '<cmd>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<CR>', desc = 'Find filtered todos', noremap = true, silent = true },
	},
	opts = {},
}
