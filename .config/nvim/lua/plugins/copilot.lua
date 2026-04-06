-- Code suggestions using GitHub Copilot
-- https://github.com/zbirenbaum/copilot.lua

return {
    'zbirenbaum/copilot.lua',
    event = 'LspAttach',
    cmd = 'Copilot',
    opts = {
        suggestion = { enabled = false }, -- suggestions will be handled by blink
        panel = { enabled = false },
        filetypes = {
            markdown = true,
            help = true,
        },
    },
}
