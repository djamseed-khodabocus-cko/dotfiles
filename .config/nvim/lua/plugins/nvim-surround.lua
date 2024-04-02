-- Add/change/delete surrounding delimeter pairs with ease
--     Add: ys{motion}{char}
--     Delete: ds{motion}{char}
--     Change: cs{motion}{char}
return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` for the latest features
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
}
