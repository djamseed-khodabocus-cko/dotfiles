-- Package manager that installs and manages LSP servers,
-- DAP servers, linters and formatters
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"gofumpt", -- Stricter Go formatter
				"goimports", -- Formatter for Go imports
				"prettier", -- Opiniated code formatter
				"ruff", -- Python linter and formatter
				"shfmt", -- Shell script formatter
				"stylua", -- Opiniated Lua formatter
			},
		})
	end,
}
