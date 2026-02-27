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
        local fileTypes = {
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

        require('nvim-treesitter').install(fileTypes)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = fileTypes,
            callback = function() vim.treesitter.start() end,
        })
    end,
}
