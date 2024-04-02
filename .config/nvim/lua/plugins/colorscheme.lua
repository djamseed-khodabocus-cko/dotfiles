-- Catppuccin theme with mocha flavor
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				integrations = {
					alpha = true,
					cmp = true,
					dap = true,
					dap_ui = true,
					gitsigns = true,
					harpoon = true,
					indent_blankline = {
						enabled = true,
						scope_color = "lavender",
						colored_indent_levels = false,
					},
					lsp_trouble = false,
					mason = true,
					noice = false,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
					notify = false,
					nvimtree = true,
					semantic_tokens = true,
					telescope = {
						enabled = true,
					},
					treesitter_context = false,
					treesitter = true,
					which_key = true,
				},
			})

			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
