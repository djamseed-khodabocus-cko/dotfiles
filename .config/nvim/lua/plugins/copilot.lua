-- Code suggestions using GitHub Copilot
-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/giuxtaposition/blink-cmp-copilot

vim.pack.add({
    { src = 'https://github.com/zbirenbaum/copilot.lua' },
    { src = 'https://github.com/giuxtaposition/blink-cmp-copilot' },
})

vim.api.nvim_create_autocmd('InsertEnter', {
    group = vim.api.nvim_create_augroup('copilot-deferred-setup', { clear = true }),
    once = true,
    desc = 'Set up copilot.lua on first insert',
    callback = function()
        require('copilot').setup({
            -- Completions are served through blink.cmp, not copilot's own UI
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        })
    end,
})
