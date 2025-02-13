-- Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
-- https://github.com/mfussenegger/nvim-jdtls

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls/workspace/' .. project_name

local config = {
	cmd = { vim.fn.expand('/opt/homebrew/bin/jdtls'), '-data', workspace_dir },
	root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = 'fernflower' },
		},
	},
}

require('jdtls').start_or_attach(config)
