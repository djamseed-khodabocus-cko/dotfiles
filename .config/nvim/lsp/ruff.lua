-- LSP implementation for Ruff,
-- https://github.com/astral-sh/ruff

return {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },
    settings = {
        lineLength = 120,
    },
}
