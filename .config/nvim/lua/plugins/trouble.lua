return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local map = require("core.utils").map
		local trouble = require("trouble")

		map("n", "<leader>tt", function()
			trouble.toggle()
		end, { desc = "Trouble: Open/Close" })

		map("n", "<leader>tp", function()
			trouble.previous({ skip_groups = true, jump = true })
		end, { desc = "Trouble: Jump to the previous item" })

		map("n", "<leader>tn", function()
			trouble.next({ skip_groups = true, jump = true })
		end, { desc = "Trouble: Jump to the next item" })

		map("n", "<leader>tf", function()
			trouble.first({ skip_groups = true, jump = true })
		end, { desc = "Trouble: Jump to the first item" })

		map("n", "<leader>tl", function()
			trouble.last({ skip_groups = true, jump = true })
		end, { desc = "Trouble: Jump to the last item" })
	end,
}
