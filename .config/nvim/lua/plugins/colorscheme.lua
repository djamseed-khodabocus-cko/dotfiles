-- Dark theme inspired by IBM carbon
-- https://github.com/nyoom-engineering/oxocarbon.nvim

vim.pack.add({ 'https://github.com/nyoom-engineering/oxocarbon.nvim' })

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('colorscheme-overrides', { clear = true }),
    callback = function() vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { link = 'PmenuSel' }) end,
})

vim.cmd.colorscheme('oxocarbon')
