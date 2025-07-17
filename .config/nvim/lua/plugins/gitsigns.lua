-- Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim

return {
	'lewis6991/gitsigns.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local gs = require('gitsigns')
		local keymap = require('core.utils').keymap

		gs.setup({
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				keymap('<leader>hb', function()
					gs.blame_line({ full = false })
				end, { buffer = bufnr, desc = 'Git blame line' })
				keymap('<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Git [D]iff against index' })
				keymap('<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Git [P]review hunk' })
				keymap('<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'Git [S]tage hunk' })
				keymap('<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Git [R]eset hunk' })
				keymap('<leader>hu', gs.stage_hunk, { buffer = bufnr, desc = 'Git [U]ndo stage hunk' })
			end,
		})
	end,
}
