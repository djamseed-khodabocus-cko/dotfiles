-- Native LSP and diagnostics setup

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('K', vim.lsp.buf.hover, 'Hover documentation')
        map('gD', vim.lsp.buf.declaration, 'Goto declaration')
        map('gO', vim.lsp.buf.document_symbol, 'Document symbols')
        map('gd', vim.lsp.buf.definition, 'Goto definition')
        map('gra', vim.lsp.buf.code_action, 'Code actions', { 'n', 'x' })
        map('gri', vim.lsp.buf.implementation, 'Goto implementation')
        map('grn', vim.lsp.buf.rename, 'Rename')
        map('grr', vim.lsp.buf.references, 'Goto references')
        map('grt', vim.lsp.buf.type_definition, 'Goto type definitions')
        map('gs', vim.lsp.buf.signature_help, 'Signature help')

        -- Highlight references of the word under the cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            -- Clear highlight of references
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                group = highlight_augroup,
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
                end,
            })
        end
    end,
})

-- Log only errors
vim.lsp.log.set_level('error')

-- Change diagnostic symbols in the sign column (gutter)
local diagnostic_signs = {}

if vim.g.nerd_fonts then
    local signs = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = '' }
    local text = {}
    for type, icon in pairs(signs) do
        text[vim.diagnostic.severity[type]] = icon
    end
    diagnostic_signs = { text = text }
end

vim.diagnostic.config({
    severity_sort = true,
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_text = { current_line = true },
    jump = { float = true },
    signs = diagnostic_signs,
    float = { border = 'rounded', source = 'if_many' },
})

-- Diagnostics keymaps
vim.keymap.set('n', '<leader>d', function() vim.diagnostic.setqflist({ bufnr = 0 }) end, { desc = 'Show buffer diagnostics', silent = true })
vim.keymap.set('n', '<leader>D', function() vim.diagnostic.setqflist() end, { desc = 'Show workspace diagnostics', silent = true })

-- Enable LSP servers
vim.lsp.enable({
    'bashls',
    'buf_ls',
    'gopls',
    'jsonls',
    'lua_ls',
    'ruff',
    'terraform_ls',
    'yamlls',
})

-- Get information on attached LSP clients
vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })
