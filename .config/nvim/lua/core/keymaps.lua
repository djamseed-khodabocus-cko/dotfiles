local keymap = require('core.utils').keymap

-- Disable the SPACEBAR key in NORMAL and VISUAL modes
keymap('<space>', '<Nop>', { silent = true }, { 'n', 'v' })

-- Disable the Q key in NORMAL mode
keymap('Q', '<Nop>', { silent = true })

-- Use CTRL+c to exit INSERT mode (useful for VISUAL BLOCK mode)
keymap('<C-c>', '<ESC>', { desc = 'Exit INSERT mode' }, 'i')

-- Use CTRL+s to save buffer
keymap('<C-s>', '<cmd>w<CR><ESC>', { desc = 'Save the current buffer' }, { 'i', 'n', 's', 'x' })

-- Use CTRL+q to quit the current buffer
keymap('<C-q>', '<cmd>q<CR>', { desc = 'Quit the current buffer' })

-- Better cusror movement
keymap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Move cusror down' }, { 'n', 'x' })
keymap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Move cusror up' }, { 'n', 'x' })
keymap('<C-u>', '<C-u>zz', { desc = 'Move cursor and screen up' })
keymap('<C-d>', '<C-d>zz', { desc = 'Move cursor and screen down' })

-- Keep the cursor at the same position when searching word under it
keymap('n', 'nzzzv', { desc = 'Repeat search in the same direction' })
keymap('N', 'Nzzzv', { desc = 'Repeat search in the same direction (backward)' })

-- Join line below to the current one and keep with one
-- space in-between the cursor at the beginning of the line
keymap('J', 'mzJ`z', { desc = 'Join line below to the current one' })

-- Pane navigation
keymap('<C-j>', '<C-w>j', { desc = 'Move focus to the window below' })
keymap('<C-k>', '<C-w>k', { desc = 'Move focus to the window above' })
keymap('<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
keymap('<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })

-- Quickfix navigation
keymap('<C-j>', '<cmd>cprev<CR>zz', { desc = 'Jump to previous match' })
keymap('<C-k>', '<cmd>cnext<CR>zz', { desc = 'Jump to next match' })

-- Use CTRL+ALT+j/k to move lines up/down
keymap('<C-A-j>', '<cmd>m .+1<CR>==', { desc = 'Move line(s) down' })
keymap('<C-A-k>', '<cmd>m .-2<CR>==', { desc = 'Move line(s) up' })
keymap('<C-A-j>', '<ESC><cmd>m .+1<CR>==gi', { desc = 'Move lines(s) down' }, 'i')
keymap('<C-A-k>', '<ESC><cmd>m .-2<CR>==gi', { desc = 'Move line(s) up' }, 'i')
keymap('<C-A-j>', "<cmd>m '>+1<CR>gv=gv", { desc = 'Move line(s) down' }, 'v')
keymap('<C-A-k>', "<cmd>m '<-2<CR>gv=gv", { desc = 'Move line(s) up' }, 'v')

-- Identing
keymap('>', '>>', { desc = 'Shift text to the right' })
keymap('<', '<<', { desc = 'Shift text to the left' })
keymap('>', '>gv', { desc = 'Shift text to the right' }, 'v')
keymap('<', '<gv', { desc = 'Shift text to the left' }, 'v')

-- Window management (split)
keymap('<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap('<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap('<leader>se', '<C-w>=', { desc = 'Make window splits equal sizes' })
keymap('<leader>sx', '<cmd>close<CR>', { desc = 'Close current split window' })

-- Toggle line wrapping
keymap('<leader>tw', '<cmd>set wrap!<CR>', { desc = '[T]oggle line [W]rapping' })

-- Clipboard behaviour
keymap('<leader>v', [["_dP]], { desc = 'Keep the last yanked when pasting' }, 'x')
keymap('p', '"_dP', { desc = 'Prevent pasting from replacing the clipboard in VISUAL mode' }, 'v')
keymap('x', '"_x', { desc = 'Prevent deleted characters from copying to clipboard' })
