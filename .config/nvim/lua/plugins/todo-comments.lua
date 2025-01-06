-- Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim

return {
	'folke/todo-comments.nvim',
	event = 'VeryLazy',
	keys = {
		{ '<leader>ft', '<CMD>TodoFzfLua<CR>', desc = 'Find todos', noremap = true, silent = true },
	},
	opts = {},
}
