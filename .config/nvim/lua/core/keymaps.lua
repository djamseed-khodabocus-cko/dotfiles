local keymap = require('core.utils').keymap

-- Disable the spacebar key's default behavior in Normal and Visual modes
keymap({ 'n', 'v' }, '<space>', '<Nop>', { silent = true })

-- Disable the Q key's default behavior in Normal mode
keymap('n', 'Q', '<Nop>', { silent = true })

-- Better cusror movement
keymap({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Move cusror up' })
keymap({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Move cusror down' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'Move cursor and screen up' })
keymap('n', '<C-d>', '<C-d>zz', { desc = 'Move cursor and screen down' })

-- Pane navigation
keymap('n', '<C-h>', '<C-w>h', { desc = 'Navigate to left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Navigate to window below' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Navigate to window above' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Navigate to right window' })

-- Quickfix navigation
keymap('n', '<C-k>', '<CMD>cnext<CR>zz', { desc = 'Jump to next match' })
keymap('n', '<C-j>', '<CMD>cprev<CR>zz', { desc = 'Jump to previous match' })

-- Window management (split)
keymap('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
keymap('n', '<leader>sx', '<CMD>close<CR>', { desc = 'Close current split' })

-- Use Ctrl + c to exit Insert mode (useful for Visual block mode)
keymap('i', '<C-c>', '<ESC>', { desc = 'Exit INSERT mode' })

-- Use Ctrl + s to save buffer
keymap({ 'i', 'n', 's', 'x' }, '<C-s>', '<CMD>w<CR><ESC>', { desc = 'Save the current buffer' })

-- Use Ctrl + q to quit file
keymap('n', '<C-q>', '<CMD> q<CR>', { desc = 'Quit the current buffer' })

-- Use Ctrl + Alt + j/k to move lines up/down
keymap('i', '<C-A-k>', '<ESC><CMD>m .-2<CR>==gi', { desc = 'Move line(s) up' })
keymap('i', '<C-A-j>', '<ESC><CMD>m .+1<CR>==gi', { desc = 'Move lines(s) down' })
keymap('n', '<C-A-k>', '<CMD>m .-2<CR>==', { desc = 'Move line(s) up' })
keymap('n', '<C-A-j>', '<CMD>m .+1<CR>==', { desc = 'Move line(s) down' })
keymap('v', '<C-A-k>', "<CMD>m '<-2<CR>gv=gv", { desc = 'Move line(s) up' })
keymap('v', '<C-A-j>', "<CMD>m '>+1<CR>gv=gv", { desc = 'Move line(s) down' })

-- Identing
keymap('n', '>', '>>', { desc = 'Shift text to the right' })
keymap('n', '<', '<<', { desc = 'Shift text to the left' })
keymap('v', '>', '>gv', { desc = 'Shift text to the right' })
keymap('v', '<', '<gv', { desc = 'Shift text to the left' })

-- Toggle line wrapping
keymap('n', '<leader>lw', '<CMD>set wrap!<CR>', { desc = 'Toggle line wrapping' })

-- Join line below to the current one and keep with one
-- space in-between the cursor at the beginning of the line
keymap('n', 'J', 'mzJ`z', { desc = 'Join line below to the current one' })

-- Keep the cursor at the same position when searching word under it
keymap('n', 'n', 'nzzzv', { desc = 'Repeat search in the same direction' })
keymap('n', 'N', 'Nzzzv', { desc = 'Repeat search in the same direction (backward)' })

-- Paste over highlighted text and delete the same from the void register
keymap('x', '<leader>v', '"_dP', { desc = 'Keep the last yanked when pasting' })

-- Copy text to system clipboard
keymap({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank into the system clipboard register' })
keymap('n', '<leader>Y', [["+Y]], { desc = 'Yank into the system clipboard register' })
