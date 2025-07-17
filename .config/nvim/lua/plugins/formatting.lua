-- Lightweight yet powerful formatter
-- https://github.com/stevearc/conform.nvim

return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = 'ConformInfo',
	keys = {
		{
			'<leader>cf',
			function()
				require('conform').format({ lsp_format = 'fallback', async = true, timeout_ms = 500 })
			end,
			mode = { 'n', 'v' },
			desc = 'Format',
		},
	},
	config = function()
		require('conform').setup({
			formatters = {
				csharpier = function()
					local useDotnet = not vim.fn.executable('csharpier')
					local command = useDotnet and 'dotnet csharpier' or 'csharpier'
					local version_out = vim.fn.system(command .. ' --version')
					local major_version = tonumber((version_out or ''):match('^(%d+)')) or 0
					local is_new = major_version >= 1
					local args = is_new and { 'format', '$FILENAME' } or { '--write-stdout' }
					return {
						command = command,
						args = args,
						stdin = not is_new,
						require_cwd = false,
					}
				end,
			},
			formatters_by_ft = {
				cs = { 'csharpier' },
				go = { 'goimports', 'gofumpt' },
				json = { 'prettier' },
				lua = { 'stylua' },
				markdown = { 'prettier' },
				python = { 'ruff' },
				rust = { 'rustfmt' },
				sh = { 'shfmt' },
				sql = { 'sql-formatter' },
				yaml = { 'prettier' },
				zig = { 'zig fmt' },
			},
			format_on_save = {
				lsp_format = 'fallback',
				async = false,
				timeout_ms = 500,
			},
			notify_on_error = false,
		})
	end,
}
