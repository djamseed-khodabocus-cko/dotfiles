return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	event = "LspAttach",
	version = "*",
	opts = {
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		keymap = { preset = "default" },
		signature = { enabled = true },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
