-- Configuration for the Neovim LSP clients
-- https://github.com/neovim/nvim-lspconfig

return {
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Package manager for LSP servers, DAP servers, linters and formatters
		{ 'mason-org/mason.nvim', config = true },
		-- Closes gaps between mason and lspconfig
		'mason-org/mason-lspconfig.nvim',
		-- Automatically install and upgrade third party tools
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		{
			-- Faster LuaLS setup for Neovim
			'folke/lazydev.nvim',
			ft = 'lua',
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
				},
			},
		},
		-- Useful status updates for LSP.
		{
			'j-hui/fidget.nvim',
			opts = {
				notification = {
					window = {
						winblend = 0,
					},
				},
			},
		},
		-- Allows extra capabilities provided by blink.cmp
		'saghen/blink.cmp',
	},
	config = function()
		--  This function gets run when an LSP attaches to a particular buffer.
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				local fzf = require('fzf-lua')

				map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
				map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
				map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
				map('grr', fzf.lsp_references, '[G]oto [R]eferences')
				map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')
				map('grd', fzf.lsp_definitions, '[G]oto [D]efinition')
				map('grt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')
				map('gO', fzf.lsp_document_symbols, 'Open Document Symbols')
				map('gW', fzf.lsp_live_workspace_symbols, 'Open Workspace Symbols')

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
					local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd('LspDetach', {
						group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = 'user-lsp-highlight', buffer = event2.buf })
						end,
					})
				end

				-- The following code creates a keymap to toggle inlay hints, if the language server supports them
				if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map('<leader>th', function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, '[T]oggle Inlay [H]ints')
				end
			end,
		})

		-- Log only errors
		vim.lsp.set_log_level('error')

		-- Change diagnostic symbols in the sign column (gutter)
		if vim.g.have_nerd_font then
			local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
			local diagnostic_signs = {}
			for type, icon in pairs(signs) do
				diagnostic_signs[vim.diagnostic.severity[type]] = icon
			end
			vim.diagnostic.config({ signs = { text = diagnostic_signs } })
		end

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  By adding blink.cmp, luasnip, etc, Neovim now has more capabilities.
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		-- Enable the following language servers
		local servers = {
			bashls = {},
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						completeUnimported = true,
						staticcheck = true,
						usePlaceholders = true,
						analyses = {
							nilness = true,
							useany = true,
							unusedparams = true,
						},
						codelenses = {
							gc_details = false,
							generate = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
				flags = {
					debounce_text_changes = 150,
				},
			},
			jsonls = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = 'Replace',
						},
						diagnostics = { disable = { 'missing-fields' } },
						workspace = {
							library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true },
						},
					},
				},
			},
			omnisharp = {
				cmd = {
					os.getenv('HOME') .. '/.local/share/nvim/mason/packages/omnisharp/libexec/Omnisharp',
					'--languageserver',
					'--hostPID',
					tostring(vim.fn.getpid()),
				},
			},
			ruff = {
				commands = {
					RuffAutofix = {
						function()
							vim.lsp.buf.execute_command({
								command = 'ruff.applyAutofix',
								arguments = {
									{ uri = vim.uri_from_bufnr(0) },
								},
							})
						end,
						description = 'Ruff: Fix all auto-fixable problems',
					},
					RuffOrganizeImports = {
						function()
							vim.lsp.buf.execute_command({
								command = 'ruff.applyOrganizeImports',
								arguments = {
									{ uri = vim.uri_from_bufnr(0) },
								},
							})
						end,
						description = 'Ruff: Format imports',
					},
				},
			},
			rust_analyzer = {
				cmd = {
					'rustup',
					'run',
					'stable',
					'rust-analyzer',
				},
			},
			zls = {},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			'csharpier', -- Opiniated C# formatter
			'gofumpt', -- Stricter Go formatter
			'goimports', -- Formatter for Go imports
			'prettier', -- Opiniated code formatter
			'ruff', -- Python linter and formatter
			'shfmt', -- Shell script formatter
			'stylua', -- Opiniated Lua formatter
		})
		require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

		require('mason-lspconfig').setup({
			ensure_installed = {},
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
					require('lspconfig')[server_name].setup(server)
				end,
			},
		})
	end,
}
