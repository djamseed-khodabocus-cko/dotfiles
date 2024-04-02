-- Lightweight code formatter
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "ruff" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				sql = { "sql-formatter" },
				yaml = { "prettier" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		local map = require("core.utils").map

		map({ "n", "v" }, "<leader>fm", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format buffer on selection" })
	end,
}
