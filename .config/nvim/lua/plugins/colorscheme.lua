-- Dark theme inspired by IBM carbon
-- https://github.com/nyoom-engineering/oxocarbon.nvim

return {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    config = function() vim.cmd('colorscheme oxocarbon') end,
}
