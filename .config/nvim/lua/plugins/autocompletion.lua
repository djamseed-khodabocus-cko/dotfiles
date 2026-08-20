-- Performant, batteries-included completion plugin for Neovim
-- https://github.com/Saghen/blink.cmp

vim.pack.add({
    { src = 'https://github.com/rafamadriz/friendly-snippets' },
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
})

vim.cmd('packadd friendly-snippets')
vim.cmd('packadd blink.cmp')

require('blink.cmp').setup({
    appearance = {
        nerd_font_variant = 'normal',
        use_nvim_cmp_as_default = false,
    },
    completion = {
        accept = {
            auto_brackets = { enabled = true },
        },
        documentation = {
            auto_show = false,
            window = {
                border = 'rounded',
                scrollbar = false,
            },
        },
        ghost_text = { enabled = false },
        list = {
            selection = {
                preselect = true,
                auto_insert = false,
            },
        },
        menu = {
            auto_show = function(ctx) return ctx.mode ~= 'cmdline' or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype()) end,
            draw = {
                components = {
                    kind_icon = {
                        text = function(ctx)
                            if ctx.kind == 'Copilot' then
                                return ''
                            end
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                    },
                },
                columns = {
                    { 'kind_icon' },
                    { 'label', 'label_description', gap = 1 },
                    { 'kind' },
                },
            },
            scrollbar = false,
            scrolloff = 1,
        },
    },
    keymap = {
        preset = 'default',
        ['<C-space>'] = {},
        ['<C-a>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },
    signature = {
        enabled = true,
        window = {
            border = 'rounded',
            show_documentation = true,
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
            copilot = {
                name = 'copilot',
                module = 'blink-cmp-copilot',
                score_offset = 100,
                async = true,
                transform_items = function(_, items)
                    local kinds = require('blink.cmp.types').CompletionItemKind
                    local copilot_kind = #kinds + 1
                    kinds[copilot_kind] = 'Copilot'
                    for _, item in ipairs(items) do
                        item.kind = copilot_kind
                    end
                    return items
                end,
            },
        },
    },
})
