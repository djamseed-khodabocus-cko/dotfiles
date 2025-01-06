-- Mark and navigate to files
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	event = 'VeryLazy',
	config = function()
		local harpoon = require('harpoon')
		local keymap = require('core.utils').keymap

		harpoon:setup()

		keymap('n', '<leader>mb', function()
			harpoon:list():append()
		end, { desc = 'Mark buffer' })

		keymap('n', '<leader>mq', function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = 'Open the harpoon quick menu' })

		keymap('n', '<leader>mp', function()
			harpoon:list():prev()
		end, { desc = 'Go to the previous marked buffer' })

		keymap('n', '<leader>mn', function()
			harpoon:list():next()
		end, { desc = 'Go to the next marked buffer' })

		-- Switch to any marked buffer (from 1 - 9)
		for i = 1, 9 do
			keymap('n', string.format('<leader>m%s', i), function()
				harpoon:list():select(i)
			end, { desc = string.format('Switch to marked buffer %s', i) })
		end
	end,
}
