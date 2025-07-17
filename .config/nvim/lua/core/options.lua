local autocmd = require('core.utils').autocmd

-- Tab / Indentation
vim.opt.autoindent = true -- Copy indent from current line when starting new line
vim.opt.breakindent = true -- Enable wrapped lines to be indented to line up with the start of the line
vim.opt.cindent = true -- Enable automatic C programming indenting
vim.opt.expandtab = true -- Expand tabs to spaces
vim.opt.shiftwidth = 4 -- 4 spaces for indent width
vim.opt.softtabstop = 4 -- 4 spaces for tabs
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the buffer counts for
vim.opt.wrap = false -- Disable line wrapping

-- Search
vim.opt.grepformat = '%f:%l:%c:%m' -- Format to recognize for the ':grep' command output
vim.opt.grepprg = 'rg --vimgrep' -- Use 'rg' for the ':grep' command
vim.opt.hlsearch = false -- Do not highlight search terms
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.inccommand = 'split' -- Preview substitution live
vim.opt.incsearch = true -- Makes search act like search in modern browsers
vim.opt.smartcase = true -- If you include mixed case in your search, assumes you want case-sensitive search

-- Appearance
vim.opt.background = 'dark' -- ColorSchemes that can be lihght or dark will be made dark
vim.opt.cmdheight = 1 -- Numnber of screen lines to use for the command-line
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Better completion experience
vim.opt.fillchars = 'eob: ' -- Remove the `~` character at the end of a buffer
vim.opt.number = true -- Show absolute line number on cursor (when relative number is on)
vim.opt.pumblend = 10 -- Enables pseudo-transparency for the popup-menu
vim.opt.relativenumber = true -- Show relative line number
vim.opt.scrolloff = 8 -- Show a minimum of 8 lines below the cursor
vim.opt.signcolumn = 'yes' -- Show sign column so that text doesn't shift
vim.opt.termguicolors = true -- Enable 24-bit RGB color

-- File handlding
vim.opt.autoread = true -- Auto reload files changed outside nvim
vim.opt.backup = false -- Disable backup
vim.opt.swapfile = false -- Disable the use of a swapfile for a buffer
vim.opt.undofile = true -- Save undo history by default
vim.opt.writebackup = false -- Disable backup

-- Behaviour
vim.opt.backspace = 'indent,eol,start' -- Allow backspace on indent, end of line, or insert mode start position
vim.opt.belloff = 'all' -- Turn the bell off
vim.opt.confirm = true -- Show a dialog asking to save the current file(s)
vim.opt.cursorline = true -- Highlight the current cursor line
vim.opt.guicursor = '' -- Set the cursor to block in insert mode
vim.opt.iskeyword:append('-') -- Treat words with dashes as a single word
vim.opt.mouse:append('a') -- Enable mouse mode
vim.opt.showcmd = true -- Show command in the last line of the screen
vim.opt.showmode = false -- If in Insert, Replace or Visual mode, put a message on the last line
vim.opt.splitbelow = true -- Split horizontal window to the bottom
vim.opt.splitright = true -- Split vertical window to the right
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.opt.undolevels = 100 -- Max number of changes that can be undone
vim.opt.updatetime = 50 -- Make updates happen faster

-- Folding
vim.opt.foldmethod = 'marker' -- Use markers to specify folds
vim.opt.foldlevel = 99 -- Folding when above 99

-- Custom settings for the Cursor line
local set_cursorline = function(event, value, pattern)
	autocmd(event, 'CursorLineControl', { pattern = pattern }, function()
		vim.opt_local.cursorline = value
	end)
end

set_cursorline('WinLeave', false)
set_cursorline('WinEnter', true)

-- Use system clipboard as default register
-- Schedule the setting after `UiEnter` because it can increase startup-time
vim.schedule(function()
	vim.opt.clipboard:append('unnamedplus')
end)
