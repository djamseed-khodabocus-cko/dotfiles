-- Parser and syntax highlighter
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local parsers = {
            'bash',
            'c',
            'c_sharp',
            'css',
            'diff',
            'dockerfile',
            'go',
            'html',
            'javascript',
            'json',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'query',
            'rust',
            'textproto',
            'toml',
            'typescript',
            'typst',
            'vim',
            'vimdoc',
            'yaml',
            'zig',
        }

        require('nvim-treesitter').install(parsers)

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf, fileType = args.buf, args.match
                local language = vim.treesitter.language.get_lang(fileType)
                if not language then
                    return
                end
                if not vim.treesitter.language.add(language) then
                    return
                end
                vim.treesitter.start(buf, language)

                -- enables treesitter based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
