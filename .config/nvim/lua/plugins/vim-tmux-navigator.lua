-- Seamless navigation between tmux panes and nvim splits
-- https://github.com/christoomey/vim-tmux-navigator

return {
	{
		'christoomey/vim-tmux-navigator',
		event = 'VeryLazy',
		cmd = {
			'TmuxNavigateLeft',
			'TmuxNavigateDown',
			'TmuxNavigateUp',
			'TmuxNavigateRight',
			'TmuxNavigatePrevious',
		},
		keys = {
			{ '<C-h>', '<CMD><C-U>TmuxNavigateLeft<CR>' },
			{ '<C-j>', '<CMD><C-U>TmuxNavigateDown<CR>' },
			{ '<C-k>', '<CMD><C-U>TmuxNavigateUp<CR>' },
			{ '<C-l>', '<CMD><C-U>TmuxNavigateRight<CR>' },
			{ '<C-\\>', '<CMD><C-U>TmuxNavigatePrevious<CR>' },
		},
	},
}
