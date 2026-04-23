-- Dark theme inspired by IBM carbon
-- https://github.com/nyoom-engineering/oxocarbon.nvim

return {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    priority = 1000,
    config = function() vim.cmd('colorscheme oxocarbon') end,
}
