-- A collection of small QoL plugins for Neovim
-- https://github.com/folke/snacks.nvim

vim.pack.add({ 'https://github.com/folke/snacks.nvim' })
vim.g.snacks_animate = false

require('snacks').setup({
    bigfile = { enabled = true },
    dashboard = {
        enabled = true,
        sections = {
            { section = 'header' },
            { section = 'keys', gap = 1, padding = 1 },
        },
    },
    explorer = { enabled = true },
    image = { enabled = true, force = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
        enabled = true,
        prompt = '❯ ',
        layout = { cycle = false },
        sources = {
            explorer = { hidden = true, exclude = { '.git' } },
            files = { hidden = true },
            grep = { hidden = true },
        },
        win = {
            input = {
                keys = {
                    ['<C-c>'] = { 'close', mode = { 'i' } },
                },
            },
        },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
})

Snacks.toggle.indent():map('<leader>ti')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>tw')
Snacks.toggle.inlay_hints():map('<leader>th')

local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { desc = desc, silent = true, noremap = true }) end

map('\\', function() Snacks.explorer() end, 'Toggle file explorer')

map('<leader>f/', function() Snacks.picker.lines() end, '[/] Fuzzily search current buffer')
map('<leader>fb', function() Snacks.picker.buffers() end, 'Find open buffers')
map('<leader>fd', function() Snacks.picker.diagnostics() end, 'Find diagnostics in workspace')
map('<leader>ff', function() Snacks.picker.files() end, 'Find files')
map('<leader>fg', function() Snacks.picker.git_files() end, 'Find git files')
map('<leader>fh', function() Snacks.picker.help() end, 'Search help')
map('<leader>fk', function() Snacks.picker.keymaps() end, 'Find keymaps')
map('<leader>fq', function() Snacks.picker.qflist() end, 'Search in the quickfix list')
map('<leader>fr', function() Snacks.picker.recent() end, 'Find recently opened files')
map('<leader>fs', function() Snacks.picker.grep() end, 'Search current project')
map('<leader>fw', function() Snacks.picker.grep_word() end, 'Search word under cursor')
