-- Plugins that do not require any setup are defined here

return {
	{ 'nvim-tree/nvim-web-devicons', lazy = true }, -- Provide Nerd Font icons (glyphs) used by other plugins
	{ 'nvim-lua/plenary.nvim', lazy = true }, -- Reusable Lua functions that are used by other plugins
	{ 'MeanderingProgrammer/render-markdown.nvim', ft = 'markdown', opts = {} }, -- Improve viewing Markdown files in Neovim
}
