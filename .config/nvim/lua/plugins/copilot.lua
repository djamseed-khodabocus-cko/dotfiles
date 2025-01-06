-- Code suggestions using GitHub Copilot
-- https://github.com/zbirenbaum/copilot.lua

return {
	'zbirenbaum/copilot.lua',
	event = 'InsertEnter',
	cmd = 'Copilot',
	config = function()
		require('copilot').setup({
			panel = { enabled = false },
			suggestion = { enabled = false }, -- suggestions wil be handled by blink cmp
		})
	end,
}
