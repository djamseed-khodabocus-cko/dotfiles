-- Enhanced motion and search plugin
-- https://github.com/folke/flash.nvim

return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    vscode = true,
    opts = {
        label = {
            -- don't show jump labels until the pattern is long enough that
            -- typing the next character can't be swallowed as a label
            min_pattern_length = 3,
        },
        modes = {
            search = {
                enabled = true,
            },
            char = {
                jump_labels = true,
            },
        },
    },
    keys = {
        { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
        { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    },
}
