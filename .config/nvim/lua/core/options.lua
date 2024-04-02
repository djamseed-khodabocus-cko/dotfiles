local autocmd = require("core.utils").autocmd
local opt = vim.opt

-- Tab / Indentation
opt.autoindent = true -- Copy indent from current line when starting new line
opt.cindent = true -- Enable automatic C programming indenting
opt.expandtab = true -- Expand tabs to spaces
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.softtabstop = 4 -- 4 spaces for tabs
opt.tabstop = 4 -- Number of spaces that a <Tab> in the buffer counts for
opt.wrap = false -- Disable line wrapping

-- Search
opt.grepformat = "%f:%l:%c:%m" -- Format to recognize for the ":grep" command output
opt.grepprg = "rg --vimgrep" -- Use 'rg' for the ":grep" command
opt.hlsearch = false -- Do not highlight search terms
opt.ignorecase = true -- Ignore case when searching
opt.incsearch = true -- Makes search act like search in modern browsers
opt.smartcase = true -- If you include mixed case in your search, assumes you want case-sensitive search

-- Appearance
opt.background = "dark" -- ColorSchemes that can be lihght or dark will be made dark
opt.cmdheight = 1 -- Numnber of screen lines to use for the command-line
opt.completeopt = "menuone,noselect" -- Better completion experience
opt.fillchars = "eob: " -- Remove the `~` character at the end of a buffer
opt.number = true -- Show absolute line number on cursor (when relative number is on)
opt.pumblend = 19 -- Enables pseudo-transparency for the popup-menu
opt.relativenumber = true -- Show relative line number
opt.scrolloff = 10 -- Show a minimum of 10 lines below the cursor
opt.signcolumn = "yes" -- Show sign column so that text doesn't shift
opt.termguicolors = true -- Enable 24-bit RGB color

-- Behaviour
opt.belloff = "all" -- Turn the bell off
opt.backspace = "indent,eol,start" -- Allow backspace on indent, end of line, or insert mode start position
opt.backup = false -- Disable backup
opt.clipboard:append("unnamedplus") -- Use system clipboard as default register
opt.cursorline = true -- Highlight the current cursor line
opt.guicursor = "" -- Set the cursor to block in insert mode
opt.iskeyword:append("-") -- Treat words with dashes as a single word
opt.mouse:append("a") -- Enable mouse mode
opt.showcmd = true -- Show command in the last line of the screen
opt.showmode = false -- If in Insert, Replace or Visual mode, put a message on the last line
opt.splitbelow = true -- Split horizontal window to the bottom
opt.splitright = true -- Split vertical window to the right
opt.swapfile = false -- Disable the use of a swapfile for a buffer
opt.undofile = true -- Save undo history by default
opt.undolevels = 100 -- Max number of changes tht can be undone
opt.updatetime = 50 -- Make updates happen faster
opt.writebackup = false -- Disable backup

-- Folding
opt.foldmethod = "marker" -- Use markers to specify folds
opt.foldlevel = 99 -- Folding when above 99

-- Custom settings for the Cursor line
local set_cursorline = function(event, value, pattern)
	autocmd(event, "CursorLineControl", { pattern = pattern }, function()
		vim.opt_local.cursorline = value
	end)
end

set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")
