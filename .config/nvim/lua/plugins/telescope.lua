-- Fuzzy finder
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	branch = "0.1.x",
	event = "VeryLazy",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				path_display = { "smart" },
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
			priority = 100,
		})

		telescope.load_extension("fzf")

		local map = require("core.utils").map
		local builtin = require("telescope.builtin")

		map("n", "<leader>ff", function()
			builtin.find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git/" } })
		end, { desc = "Find files" })
		map("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
		map("n", "<leader>fs", builtin.live_grep, { desc = "Find string by grep" })
		map("n", "<leader>fw", builtin.grep_string, { desc = "Find word" })
		map("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
		map("n", "<leader>fr", builtin.oldfiles, { desc = "Find recently opened files" })
		map("n", "<leader>fb", builtin.buffers, { desc = "Find existing buffers" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
		map("n", "<leader>f/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 0,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
	end,
}
