-- Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim

vim.pack.add({
    { src = 'https://github.com/folke/todo-comments.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
})

require('todo-comments').setup()

vim.keymap.set('n', '<leader>ft', function() Snacks.picker.todo_comments() end, { desc = 'List todos', noremap = true, silent = true })
