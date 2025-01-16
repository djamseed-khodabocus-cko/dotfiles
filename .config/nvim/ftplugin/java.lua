-- Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
-- https://github.com/mfussenegger/nvim-jdtls

local config = {
	cmd = { vim.fn.expand('/opt/homebrew/bin/jdtls') },
	root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
