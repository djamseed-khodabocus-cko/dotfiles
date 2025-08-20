-- Package manager for LSP servers, DAP servers, linters and formatters
-- https://github.com/mason-org/mason.nvim

return {
  'mason-org/mason.nvim',
  event = 'BufReadPre',
  cmd = 'Mason',
  build = ':MasonUpdate',
  dependencies = {
    -- automatically install and upgrade third party tools
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    require('mason').setup()
    require('mason-tool-installer').setup({
      ensure_installed = {
        -- LSP servers
        'bash-language-server',
        'gopls',
        'json-lsp',
        'lua-language-server',
        'omnisharp',
        'ruff',
        'terraform-ls',
        'zls',

        -- formatters (for conform.nvim and general use)
        'csharpier',
        'gofumpt',
        'goimports',
        'prettier',
        'shfmt',
        'stylua',

        -- linters and diagnostics
        'shellcheck',
      },
      run_on_start = true,
    })
  end,
}
