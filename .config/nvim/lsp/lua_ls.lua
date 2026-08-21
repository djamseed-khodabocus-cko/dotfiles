-- Lua language server.
-- https://github.com/luals/lua-language-server

return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    -- Nested list = priority groups. `vim.fs.root` returns on the first marker it finds anywhere
    -- up the tree, so a flat list with '.git' in it roots at the enclosing repo and the config's
    -- own .luarc.json is never read as workspace config.
    root_markers = {
        {
            '.luarc.json',
            '.luarc.jsonc',
            '.luacheckrc',
            '.stylua.toml',
            'stylua.toml',
            'selene.toml',
            'selene.yml',
        },
        '.git',
    },
    settings = {
        Lua = {
            codeLens = { enable = true },
            completion = { callSnippet = 'Replace' },
            diagnostics = {
                disable = { 'missing-fields' },
                -- Only globals that hold for any Nvim Lua. Config-specific ones (Snacks,
                -- MiniIcons) live in .luarc.json, which applies when this directory is the root.
                globals = { 'vim' },
            },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
            },
            runtime = { version = 'LuaJIT' },
            workspace = {
                -- Only the Nvim runtime and this config. `nvim_get_runtime_file('lua', true)`
                -- would hand lua_ls every installed plugin's lua/ directory to index.
                library = {
                    vim.fs.joinpath(vim.env.VIMRUNTIME, 'lua'),
                    vim.fs.joinpath(vim.fn.stdpath('config'), 'lua'),
                },
                checkThirdParty = false,
            },
        },
    },
}
