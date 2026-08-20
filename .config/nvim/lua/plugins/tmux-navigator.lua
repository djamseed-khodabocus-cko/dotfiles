-- Seamless navigation between tmux panes and nvim splits
-- https://github.com/christoomey/vim-tmux-navigator

vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

local map = function(keys, cmd, desc) vim.keymap.set('n', keys, cmd, { desc = desc, silent = true }) end

map('<C-h>', ':TmuxNavigateLeft<CR>', 'Go to the left pane')
map('<C-j>', ':TmuxNavigateDown<CR>', 'Go to the lower pane')
map('<C-k>', ':TmuxNavigateUp<CR>', 'Go to the upper pane')
map('<C-l>', ':TmuxNavigateRight<CR>', 'Go to the right pane')
map('<C-\\>', ':TmuxNavigatePrevious<CR>', 'Go to the previous pane')
