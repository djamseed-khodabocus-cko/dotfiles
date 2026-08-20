local opts = { noremap = true, silent = true }

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<', '<gv', opts)

vim.keymap.set('i', '<C-c>', '<Esc>', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<C-s>', ':w<CR>', opts)

-- Paste over selection without losing yanked text
vim.keymap.set('x', 'p', [["_dp]])
vim.keymap.set('x', 'P', [["_dp]])

-- Prevent delete from registering
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', opts)
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', opts)

vim.keymap.set('n', '<C-A-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-A-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-A-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-A-Right>', ':vertical resize +2<CR>')

vim.keymap.set('n', 'Q', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>u', function()
    vim.cmd.packadd('nvim.undotree')
    require('undotree').open()
end, { desc = 'Open built-in undotree' })

vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Close the current window', silent = true })
vim.keymap.set('n', '<leader>r', ':restart<CR>', { desc = 'Restart Neovim', silent = true })
