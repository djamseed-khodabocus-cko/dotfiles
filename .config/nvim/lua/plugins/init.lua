-- Plugins that require minimal setup are defined here

return {
  -- resuable Lua functions
  { 'nvim-lua/plenary.nvim', lazy = true },
  -- icon provider (glyph or ascii)
  { 'echasnovski/mini.icons', version = '*', opts = {}, lazy = true },
  -- automatic indentation style detection
  { 'nmac427/guess-indent.nvim', event = { 'BufReadPost', 'BufNewFile' } },
  -- add character pairs automatically
  { 'echasnovski/mini.pairs', version = '*', event = { 'InsertEnter' }, opts = {} },
  -- improve viewing markdown files in Neovim
  { 'MeanderingProgrammer/render-markdown.nvim', ft = 'markdown', opts = {} },
  -- Neovim notifications and LSP progress messages
  { 'j-hui/fidget.nvim', event = 'LspAttach', opts = { notification = { window = { winblend = 0 } } } },
  -- add, delete, replace, find, highlight surrounding (brakets, quotes, etc)
  --     add surrounding with sa (in visual mode or on motion).
  --     delete surrounding with sd.
  --     replace surrounding with sr.
  --     find surrounding with sf or sF (move cursor right or left).
  --     highlight surrounding with sh.
  { 'echasnovski/mini.surround', version = '*', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },
  -- Smart and Powerful commenting
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
  { 'numToStr/Comment.nvim', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },
}
