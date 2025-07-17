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

		keymap('<leader>mb', function()
			harpoon:list():append()
		end, { desc = 'Mark buffer' })

		keymap('<leader>mq', function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = 'Open harpoon quick menu' })

		keymap('<leader>mp', function()
			harpoon:list():prev()
		end, { desc = 'Go to previous marked buffer' })

		keymap('<leader>mn', function()
			harpoon:list():next()
		end, { desc = 'Go to next marked buffer' })

		-- Switch to any marked buffer (from 1 - 9)
		for i = 1, 9 do
			keymap(string.format('<leader>m%s', i), function()
				harpoon:list():select(i)
			end, { desc = string.format('Switch to marked buffer %s', i) })
		end
	end,
}
