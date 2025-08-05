-- disable <space> in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<space>', '<Nop>', { silent = true })

-- disable the Q key in normal mode
vim.keymap.set('n', 'Q', '<Nop>', { silent = true })

-- use ctrl+c to exit insert mode (useful for visual-block mode)
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit Insert mode', noremap = true, silent = true })

-- use ctrl+q to quit the current window
-- vim.keymap.set('n', '<C-q>', ':q<CR>', { desc = 'Quit the current window', noremap = true, silent = true })

-- use ctrl+s to write the current to file
vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-s>', '<cmd>w<CR><Esc>', { desc = 'Write the current buffer to file', noremap = true, silent = true })

-- better cusror movement
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Move cusror down' })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Move cusror up' })

-- keep the cursor centered when scrolling
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move cursor and screen up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move cursor and screen down' })

-- keep the cursor at the same position when searching words under it
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Repeat search in the same direction' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Repeat search in the same direction (backward)' })

-- pane navigation
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the window above' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })

-- splitting and resizing
vim.keymap.set('n', '<C-A-Up>', ':resize +2<CR>', { desc = 'Increase window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-A-Down>', ':resize -2<CR>', { desc = 'Decrease window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-A-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width', noremap = true, silent = true })
vim.keymap.set('n', '<C-A-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width', noremap = true, silent = true })

-- use ctrl+alt+j/k to move lines up/down
vim.keymap.set('n', '<C-A-j>', ':m .+1<CR>==', { desc = 'Move line(s) down', noremap = true, silent = true })
vim.keymap.set('n', '<C-A-k>', ':m .-2<CR>==', { desc = 'Move line(s) up', noremap = true, silent = true })
vim.keymap.set('i', '<C-A-j>', '<ESC>:m .+1<CR>==gi', { desc = 'Move lines(s) down', noremap = true, silent = true })
vim.keymap.set('i', '<C-A-k>', '<ESC>:m .-2<CR>==gi', { desc = 'Move line(s) up', noremap = true, silent = true })
vim.keymap.set('v', '<C-A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move line(s) down', noremap = true, silent = true })
vim.keymap.set('v', '<C-A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move line(s) up', noremap = true, silent = true })

-- better identing
vim.keymap.set('n', '>', '>>', { desc = 'Shift text to the right' })
vim.keymap.set('n', '<', '<<', { desc = 'Shift text to the left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Shift text to the right' })
vim.keymap.set('v', '<', '<gv', { desc = 'Shift text to the left' })

-- clipboard behaviour
vim.keymap.set('x', '<leader>v', [["_dP]], { desc = 'Keep the last yanked when pasting', noremap = true })
vim.keymap.set('v', 'p', '"_dP', { desc = 'Prevent pasting from replacing the clipboard in Visual mode' })
vim.keymap.set('n', 'x', '"_x', { desc = 'Prevent deleted characters from copying to clipboard' })
