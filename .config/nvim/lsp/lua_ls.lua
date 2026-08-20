-- Lua language server.
-- https://github.com/luals/lua-language-server

return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.git',
        '.luacheckrc',
        '.luarc.json',
        '.luarc.jsonc',
        '.stylua.toml',
        'selene.toml',
        'selene.yml',
        'stylua.toml',
    },
    settings = {
        Lua = {
            codeLens = { enable = true },
            completion = { callSnippet = 'Replace' },
            diagnostics = {
                disable = { 'missing-fields' },
                globals = { 'vim', 'Snacks' },
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
