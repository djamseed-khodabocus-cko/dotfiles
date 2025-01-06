-- Add pairs automatically
-- https://github.com/windwp/nvim-autopairs

return {
	'windwp/nvim-autopairs',
	event = { 'InsertEnter' },
	config = function()
		require('nvim-autopairs').setup({
			check_ts = true, -- Enable Treesitter
			map_cr = true,
			ts_config = {
				lua = { 'string' }, -- Don't add pairs in lua string treesitter nodes
				javascript = { 'template_string' }, -- Don't add pairs in javscript template_string treesitter nodes
			},
		})
	end,
}
