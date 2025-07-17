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
			{ '<C-h>', '<cmd><C-U>TmuxNavigateLeft<CR>' },
			{ '<C-j>', '<cmd><C-U>TmuxNavigateDown<CR>' },
			{ '<C-k>', '<cmd><C-U>TmuxNavigateUp<CR>' },
			{ '<C-l>', '<cmd><C-U>TmuxNavigateRight<CR>' },
			{ '<C-\\>', '<cmd><C-U>TmuxNavigatePrevious<CR>' },
		},
	},
}
