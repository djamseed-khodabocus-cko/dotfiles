local opts = { noremap = true, silent = true }

vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

vim.keymap.set('x', '>', '>gv', opts)
vim.keymap.set('x', '<', '<gv', opts)

vim.keymap.set('i', '<C-c>', '<Esc>', opts)
vim.keymap.set({ 'n', 'x' }, '<C-s>', '<cmd>w<CR>', opts)

-- Prevent delete from registering
vim.keymap.set({ 'n', 'x' }, 'd', '"_d', opts)
vim.keymap.set({ 'n', 'x' }, 'x', '"_x', opts)

vim.keymap.set('n', 'Q', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>u', function()
    vim.cmd.packadd('nvim.undotree')
    require('undotree').open()
end, { desc = 'Open built-in undotree' })

vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Close the current window', silent = true })
vim.keymap.set('n', '<leader>r', ':restart<CR>', { desc = 'Restart Neovim', silent = true })
