-- Status line
return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("lualine").setup({
			options = {
				component_separators = "",
				globalstatus = true,
				section_separators = "",
				theme = "catppuccin",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filesize", "filename" },
				lualine_c = {
					"location",
					"progress",
					{
						function()
							local msg = "No Active Lsp"
							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
							local clients = vim.lsp.get_active_clients()

							if next(clients) == nil then
								return msg
							end

							for _, client in ipairs(clients) do
								local filetypes = client.config.filetypes
								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
									return client.name
								end
							end

							return msg
						end,
						icon = "  LSP:",
						color = { fg = "#ffffff", gui = "bold" },
					},
				},
				lualine_x = {
					{ "encoding", fmt = string.upper },
					{ "fileformat" },
					{ "branch", gui = "bold" },
					{ "diff", symbols = { added = " ", modified = "󰝤 ", removed = " " } },
				},
				lualine_y = {},
				lualine_z = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic", "nvim_lsp" },
						sections = { "error", "warn", "info", "hint" },
						diagnostics_color = {
							-- Same values as the general color option can be used here.
							error = "DiagnosticError", -- Changes diagnostics" error color.
							warn = "DiagnosticWarn", -- Changes diagnostics" warn color.
							info = "DiagnosticInfo", -- Changes diagnostics" info color.
							hint = "DiagnosticHint", -- Changes diagnostics" hint color.
						},
						symbols = { error = " ", warn = " ", info = " " },
						colored = true, -- Displays diagnostics status in color if set to true.
						update_in_insert = false, -- Update diagnostics in insert mode.
						always_visible = false, -- Show diagnostics even if there are none.
					},
					{ "filetype", colored = false },
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
