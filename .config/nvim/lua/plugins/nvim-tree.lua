-- File explorer that replaces netrw
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store", "^.git$" },
			},
			renderer = {
				group_empty = true,
			},
			view = {
				relativenumber = true,
				width = 40,
			},
		})

		local map = require("core.utils").map

		map("n", "<leader>ee", "<CMD>NvimTreeToggle<CR>", { desc = "Open/Close file explorer" })
		map("n", "<leader>ef", "<CMD>NvimTreeFindFileToggle<CR>", { desc = "Open file explorer on current buffer" })
		map("n", "<leader>ec", "<CMD>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
	end,
}
