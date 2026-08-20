-- Language server for bash, written using tree sitter in typescript.
-- https://github.com/bash-lsp/bash-language-server

return {
    cmd = { 'bash-language-server', 'start' },
    settings = {
        bashIde = {
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
        },
    },
    filetypes = { 'bash', 'sh', 'zsh' },
    root_markers = { '.git' },
}
