-- Pretty list for showing diagnostics
-- https://github.com/folke/trouble.nvim

return {
	'folke/trouble.nvim',
	event = 'VeryLazy',
	config = function()
		local keymap = require('core.utils').keymap
		local trouble = require('trouble')

		keymap('n', '<leader>tt', function()
			trouble.toggle({ mode = 'diagnostics', auto_preview = false })
		end, { desc = 'Open/Close' })
		keymap('n', '<leader>tp', function()
			trouble.previous({ mode = 'diagnostics', skip_groups = true, jump = true })
		end, { desc = 'Jump to the previous item' })
		keymap('n', '<leader>tn', function()
			trouble.next({ mode = 'diagnostics', skip_groups = true, jump = true })
		end, { desc = 'Jump to the next item' })
		keymap('n', '<leader>tf', function()
			trouble.first({ mode = 'diagnostics', skip_groups = true, jump = true })
		end, { desc = 'Jump to the first item' })
		keymap('n', '<leader>tl', function()
			trouble.last({ mode = 'diagnostics', skip_groups = true, jump = true })
		end, { desc = ' Jump to the last item' })
	end,
}
