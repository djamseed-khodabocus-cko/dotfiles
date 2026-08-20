-- Tab / Indentation
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.wrap = false

-- Search
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- Appearance
vim.opt.fillchars = { eob = ' ' }
vim.opt.guicursor = 'n-v-c-sm:block-blinkwait175-blinkoff150-blinkon175'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.winborder = 'rounded'

-- File handling
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false

vim.opt.confirm = true
vim.opt.isfname:append('@-@')
vim.opt.iskeyword:append('-')
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.synmaxcol = 180
vim.opt.timeoutlen = 300
vim.opt.updatetime = 100

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Use the system clipboard as the default register
vim.schedule(function() vim.opt.clipboard:append('unnamedplus') end)
