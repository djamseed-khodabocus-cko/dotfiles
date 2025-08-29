-- Plugins that require minimal setup are defined here

return {
  -- resuable Lua functions
  { 'nvim-lua/plenary.nvim', lazy = true },
  -- automatic indentation style detection
  { 'nmac427/guess-indent.nvim', event = { 'BufReadPost', 'BufNewFile' } },
  -- improve viewing markdown files in Neovim
  { 'MeanderingProgrammer/render-markdown.nvim', ft = 'markdown', opts = {} },
  -- Neovim notifications and LSP progress messages
  { 'j-hui/fidget.nvim', event = 'LspAttach', opts = { notification = { window = { winblend = 0 } } } },
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
