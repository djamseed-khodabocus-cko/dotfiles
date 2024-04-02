-- Plugins that do not require any setup are defined here
return {
	{ "nvim-lua/plenary.nvim", lazy = true }, -- Lua functions that are used by other plugins
	{ "github/copilot.vim", event = "VeryLazy" }, -- Github Copilot
	{ "tpope/vim-fugitive", event = "VeryLazy" }, -- Git wrapper
	{ "tpope/vim-sleuth", event = "VeryLazy" }, -- Detect tabstop and shiftwidth automatically
}
