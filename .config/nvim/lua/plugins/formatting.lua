-- Lightweight yet powerful formatter
-- https://github.com/stevearc/conform.nvim

vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

local conform = require('conform')

local csharpier_cache = nil
local function csharpier_config()
    if csharpier_cache then
        return csharpier_cache
    end

    local command = vim.fn.executable('csharpier') == 1 and 'csharpier' or 'dotnet csharpier'
    local version_out = vim.fn.system(command .. ' --version')
    local is_new = (tonumber((version_out or ''):match('^(%d+)')) or 0) >= 1

    csharpier_cache = {
        command = command,
        args = is_new and { 'format', '$FILENAME' } or { '--write-stdout' },
        stdin = not is_new,
        require_cwd = false,
    }
    return csharpier_cache
end

conform.setup({
    default_format_opts = { lsp_format = 'fallback' },
    formatters_by_ft = {
        cs = { 'csharpier' },
        go = { 'goimports', 'gofumpt' },
        json = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        python = { 'ruff_organize_imports', 'ruff_format' },
        sh = { 'shfmt' },
        sql = { 'sql_formatter' },
        yaml = { 'prettier' },
    },
    format_on_save = {
        async = false,
        timeout_ms = 500,
    },
    formatters = {
        csharpier = function() return csharpier_config() end,
        shfmt = { prepend_args = { '-i', '2' } },
    },
    notify_on_error = false,
})

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function() conform.format({ lsp_format = 'fallback', async = true }) end, { desc = 'Format buffer' })
