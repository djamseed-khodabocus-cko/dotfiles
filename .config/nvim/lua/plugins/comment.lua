-- Smart and Powerful commenting
-- https://github.com/numToStr/Comment.nvim
-- NORMAL mode
--     gcc -> Linewise comment
--     gbc -> Blockwise comment
--     [count]gcc -> Number of lines as prefix + linewise comment
--     [count]gbc -> Number of lines as prefix + blockwise comment
--     gc[count]{motion} -> Coment the region with linewise comment
--     hb[count]{motion} -> Comment the region with blockwise comment
--  VISUAL Mode
--      gc -> Comment the region with linewise comment
--      gb -> Comment the region with blockwise comment
return {
	'numToStr/Comment.nvim',
	event = { 'BufReadPost', 'BufNewFile' },
	opts = {},
}
