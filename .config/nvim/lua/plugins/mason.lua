-- Package manager for LSP servers, DAP servers, linters and formatters
-- https://github.com/mason-org/mason.nvim

vim.pack.add({
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
})

require('mason').setup({
    registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
    },
})

require('mason-tool-installer').setup({
    ensure_installed = {
        -- LSP servers
        'bash-language-server',
        'buf',
        'gopls',
        'json-lsp',
        'lua-language-server',
        'roslyn',
        'ruff',
        'terraform-ls',
        'yaml-language-server',

        -- Formatters
        'csharpier',
        'gofumpt',
        'goimports',
        'prettier',
        'shfmt',
        'sql-formatter',
        'stylua',

        -- Debug adapters (registered with nvim-dap in lua/plugins/debug.lua)
        'delve',
        'netcoredbg',

        -- Linters and diagnostics
        'shellcheck',
    },
})
