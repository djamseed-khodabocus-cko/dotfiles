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
        StatusLine = { fg = 'love', bg = 'surface', blend = 10 },
      },
    })
    vim.cmd('colorscheme rose-pine')
  end,
}
