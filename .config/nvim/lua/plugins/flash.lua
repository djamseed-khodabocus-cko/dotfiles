-- Enhanced motion and search plugin
-- https://github.com/folke/flash.nvim

return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    vscode = true,
    opts = {
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
        { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
}
