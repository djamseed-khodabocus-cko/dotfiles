-- Displays a popup with possible pending keybinding
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>B", group = "[B]reakpoint" },
			{ "<leader>B_", hidden = true },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>d_", hidden = true },
			{ "<leader>e", group = "[E]xplore" },
			{ "<leader>e_", hidden = true },
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>f_", hidden = true },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>g_", hidden = true },
			{ "<leader>h", group = "[H]arpoon" },
			{ "<leader>h_", hidden = true },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>r_", hidden = true },
			{ "<leader>s", group = "[S]plit" },
			{ "<leader>s_", hidden = true },
			{ "<leader>t", group = "[T]rouble" },
			{ "<leader>t_", hidden = true },
		})
	end,
}
