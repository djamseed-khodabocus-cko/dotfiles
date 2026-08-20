-- Improve Neovim experience with minimal effort
-- https://github.com/nvim-mini/mini.nvim

vim.pack.add({
    { src = 'https://github.com/nvim-mini/mini.ai' },
    { src = 'https://github.com/nvim-mini/mini.icons' },
    { src = 'https://github.com/nvim-mini/mini.pairs' },
    { src = 'https://github.com/nvim-mini/mini.surround' },
})

-- Extend and create a/i textobjects
local ai = require('mini.ai')

ai.setup({
    custom_textobjects = {
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
    },
    n_lines = 500,
})

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

-- Add character pairs automatically
require('mini.pairs').setup()

-- Add, delete, replace, find, highlight surrounding (quotes, brackets, etc...)
require('mini.surround').setup({
    mappings = {
        add = 'sa', -- Add surrounding (e.g., saiw")
        delete = 'sd', -- Delete surrounding (e.g., sdiw")
        find = 'sf', -- Find surrounding to the right
        find_left = 'sF', -- Find surrounding to the left
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding (e.g., sr"' )
    },
})
