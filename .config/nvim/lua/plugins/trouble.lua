return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local map = require("core.utils").map
		local trouble = require("trouble")

		map("n", "<leader>tt", function()
			trouble.toggle({ mode = "diagnostics", auto_preview = false })
		end, { desc = "Trouble: Open/Close" })

		map("n", "<leader>tp", function()
			trouble.previous({ mode = "diagnostics", skip_groups = true, jump = true })
		end, { desc = "Trouble: Jump to the previous item" })

		map("n", "<leader>tn", function()
			trouble.next({ mode = "diagnostics", skip_groups = true, jump = true })
		end, { desc = "Trouble: Jump to the next item" })

		map("n", "<leader>tf", function()
			trouble.first({ mode = "diagnostics", skip_groups = true, jump = true })
		end, { desc = "Trouble: Jump to the first item" })

		map("n", "<leader>tl", function()
			trouble.last({ mode = "diagnostics", skip_groups = true, jump = true })
		end, { desc = "Trouble: Jump to the last item" })
	end,
}
