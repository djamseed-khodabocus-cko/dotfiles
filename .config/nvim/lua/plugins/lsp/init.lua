-- Configuration for the Neovim LSP client
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0,
					},
				},
			},
		},
	},
	event = "VeryLazy",
	config = function()
		local function on_attach(_, bufnr)
			-- Define specific keymaps for LSP related functions
			local function keymap(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			local telescope = require("telescope.builtin")

			keymap("gd", telescope.lsp_definitions, "LSP: Goto Definition")
			keymap("gr", telescope.lsp_references, "LSP: Goto References")
			keymap("gI", telescope.lsp_implementations, "LSP: Goto Implementation")
			keymap("gD", vim.lsp.buf.declaration, "LSP: Goto Declaration")
			keymap("K", vim.lsp.buf.hover, "LSP: Hover Documentation")
			keymap("<C-k>", vim.lsp.buf.signature_help, "LSP: Signature Help")
			keymap("<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
			keymap("<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
			keymap("<leader>D", telescope.lsp_type_definitions, "LSP: Type Definition")
			keymap("<leader>ds", telescope.lsp_document_symbols, "LSP: Document Symbols")

			-- Command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with the LSP formatter" })
		end

		-- Change the diagnostic symbols in the sign column
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Configure the Mason UI
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		-- List of LSP servers to install
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"bufls",
				"dockerls",
				"gopls",
				"htmx",
				"jsonls",
				"lua_ls",
				"omnisharp",
				"pyright",
				"ruff_lsp",
				"rust_analyzer",
				"yamlls",
			},
			-- Auto-install configured servers
			automatic_installation = true,
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				-- Protobuf
				["bufls"] = function()
					lspconfig.bufls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						cmd = { "bufls", "serve" },
						filetypes = { "proto" },
					})
				end,

				-- Docker
				["dockerls"] = function()
					lspconfig.bufls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						cmd = { "docker-langserver", "--stdio" },
					})
				end,

				-- Go
				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
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
					})
				end,

				-- Lua
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									},
								},
							},
						},
					})
				end,

				-- Omnisharp (C#)
				["omnisharp"] = function()
					lspconfig.omnisharp.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						cmd = {
							os.getenv("HOME") .. "/.local/share/nvim/mason/packages/omnisharp/libexec/Omnisharp",
							"--languageserver",
							"--hostPID",
							tostring(vim.fn.getpid()),
						}
					})
				end,

				-- Python
				["pyright"] = function()
					lspconfig.pyright.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							pyright = {
								disableOrganizeImports = false,
								analysis = {
									useLibraryCodeForTypes = true,
									autoSearchPaths = true,
									diagnosticMode = "workspace",
									autoImportCompletions = true,
								},
							},
						},
					})
				end,

				-- Rust
				["rust_analyzer"] = function()
					lspconfig.rust_analyzer.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						cmd = {
							"rustup",
							"run",
							"stable",
							"rust-analyzer",
						},
					})
				end,
			},
		})
	end,
}
