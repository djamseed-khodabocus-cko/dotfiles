-- Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim

vim.pack.add({
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

require('gitsigns').setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
    },
})

-- Keymap helper function
local map = function(keys, cmd, desc) vim.keymap.set('n', keys, cmd, { desc = desc, silent = true }) end

-- Keymaps
map('<leader>gb', ':Gitsigns blame_line<CR>', 'Git blame line')
map('<leader>gd', ':Gitsigns diffthis<CR>', 'Git diff against index')
map('<leader>gp', ':Gitsigns preview_hunk<CR>', 'Git preview hunk')
map('<leader>gP', ':Gitsigns preview_hunk_inline<CR>', 'Git preview hunk inline')
map('<leader>gr', ':Gitsigns reset_hunk<CR>', 'Git reset hunk')
map('<leader>gR', ':Gitsigns reset_buffer<CR>', 'Git reset buffer')
map('<leader>gs', ':Gitsigns stage_hunk<CR>', 'Git stage hunk')
map('<leader>gS', ':Gitsigns stage_buffer<CR>', 'Git stage buffer')
map('<leader>gu', ':Gitsigns undo_stage_hunk<CR>', 'Git undo stage hunk')
