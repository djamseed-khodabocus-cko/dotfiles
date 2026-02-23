-- Soho vibes for Neovim
-- https://github.com/rose-pine/neovim

return {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    config = function()
        require('rose-pine').setup({
            variant = 'moon',
            styles = {
                italic = false,
                transparency = true,
            },
            highlight_groups = {
                Visual = { fg = 'gold', bg = 'text', blend = 10, inherit = false },
            },
        })
        vim.cmd('colorscheme rose-pine')
    end,
}
