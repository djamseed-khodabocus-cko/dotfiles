-- Mark and navigate to files
return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	config = function()
		local harpoon = require("harpoon")
		local map = require("core.utils").map

		harpoon:setup()

		map("n", "<leader>hm", function()
			harpoon:list():append()
		end, { desc = "Mark file with harpoon" })

		map("n", "<leader>hq", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open the harpoon quick menu" })

		map("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "Go to the previous marked buffer" })

		map("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "Go to the next marked buffer" })

		-- Switch to any marked buffer (from 1 - 9)
		for i = 1, 9 do
			map("n", string.format("<leader>%s", i), function()
				harpoon:list():select(i)
			end, { desc = string.format("Switch to marked buffer %s", i) })
		end
	end,
}
