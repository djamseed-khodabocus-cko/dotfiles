-- Git integration for buffers
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gs = require("gitsigns")
		local map = require("core.utils").map

		gs.setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				map("n", "<leader>gb", function()
					gs.blame_line({ full = false })
				end, { buffer = bufnr, desc = "Git blame line" })
				map("n", "<leader>gh", gs.preview_hunk, { buffer = bufnr, desc = "Git preview hunk" })
				map("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "Git stage hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "Git reset hunk" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Git undo stage hunk" })
			end,
		})
	end,
}
