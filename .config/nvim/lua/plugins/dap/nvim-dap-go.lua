-- Extension for nvim-dap for launching the go debugger
return {
	"leoluz/nvim-dap-go",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	ft = "go",
	config = function()
		require("dap-go").setup({
			delve = {
				path = vim.fn.expand("~/.local/share/nvim/mason/bin/dlv"),
			},
		})
	end,
}
