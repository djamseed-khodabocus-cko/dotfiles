-- Performant, batteries-included completion plugin for Neovim
-- https://github.com/Saghen/blink.cmp

return {
	'saghen/blink.cmp',
	dependencies = {
		'rafamadriz/friendly-snippets',
		'giuxtaposition/blink-cmp-copilot',
	},
	event = 'LspAttach',
	version = '*',
	opts = {
		appearance = {
			-- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
			kind_icons = {
				Copilot = '',
				Text = '󰉿',
				Method = '󰊕',
				Function = '󰊕',
				Constructor = '󰒓',
				Field = '󰜢',
				Variable = '󰆦',
				Property = '󰖷',
				Class = '󱡠',
				Interface = '󱡠',
				Struct = '󱡠',
				Module = '󰅩',
				Unit = '󰪚',
				Value = '󰦨',
				Enum = '󰦨',
				EnumMember = '󰦨',
				Keyword = '󰻾',
				Constant = '󰏿',
				Snippet = '󱄽',
				Color = '󰏘',
				File = '󰈔',
				Reference = '󰬲',
				Folder = '󰉋',
				Event = '󱐋',
				Operator = '󰪚',
				TypeParameter = '󰬛',
			},
			nerd_font_variant = 'normal',
			use_nvim_cmp_as_default = false,
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = { window = { border = 'single' } },
			ghost_text = { enabled = false },
			menu = {
				auto_show = function(ctx)
					return ctx.mode ~= 'cmdline' or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
				end,
				draw = {
					columns = {
						{ 'label', 'label_description', gap = 1 },
						{ 'kind_icon', 'kind' },
					},
				},
			},
		},
		keymap = {
			preset = 'default',
			['<C-space>'] = {},
			['<C-a>'] = { 'show', 'show_documentation', 'hide_documentation' },
		},
		signature = { enabled = true },
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
			providers = {
				copilot = {
					name = 'copilot',
					module = 'blink-cmp-copilot',
					score_offset = 100,
					async = true,
				},
			},
		},
	},
	opts_extend = { 'sources.default' },
}
