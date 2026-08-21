-- Parser and syntax highlighter
-- https://github.com/nvim-treesitter/nvim-treesitter

vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
})

local treesitter = require('nvim-treesitter')

local parsers = {
    'bash',
    'c_sharp',
    'css',
    'diff',
    'dockerfile',
    'go',
    'graphql',
    'html',
    'javascript',
    'json',
    'lua',
    'luadoc',
    'make',
    'markdown',
    'markdown_inline',
    'proto',
    'python',
    'rust',
    'sql',
    'templ',
    'terraform',
    'toml',
    'typescript',
    'typst',
    'vimdoc',
    'yaml',
    'xml',
    'zig',
}

treesitter.install(parsers)

local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then
        return
    end

    vim.treesitter.start(buf, language)

    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
    if has_indent_query then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

local available_parsers = {}
for _, lang in ipairs(treesitter.get_available()) do
    available_parsers[lang] = true
end

-- `get_installed` re-scans the parser directory on every call, so cache it and only add to the
-- set as parsers are installed. Without this, every FileType event costs a filesystem walk.
local installed_parsers = {}
for _, lang in ipairs(treesitter.get_installed('parsers')) do
    installed_parsers[lang] = true
end

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)

        if not language then
            return
        end

        if installed_parsers[language] or not available_parsers[language] then
            treesitter_try_attach(buf, language)
        else
            treesitter.install(language):await(function()
                installed_parsers[language] = true
                treesitter_try_attach(buf, language)
            end)
        end
    end,
})
