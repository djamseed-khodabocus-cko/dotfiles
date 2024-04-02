local map = require("core.utils").map

-- Navigation
--
-- Better cusror movement
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move cusror up" })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move cusror down" })

map("n", "<C-u>", "<C-u>zz", { desc = "Move cursor and screen up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Move cursor and screen down" })

-- Pane navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate to window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate to window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate to right window" })

-- Quickfix navigation
map("n", "<C-k>", "<CMD>cnext<CR>zz", { desc = "Jump to next match" })
map("n", "<C-j>", "<CMD>cprev<CR>zz", { desc = "Jump to previous match" })

-- Window Management
--
-- Split windows
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close current split" })

-- Exiting
--
-- Use Ctrl + c to exit INSERT mode (useful for VISUAL block mode)
map("i", "<C-c>", "<ESC>", { desc = "Exit INSERT mode with Ctrl + c" })

-- Use Ctrl + s to save buffer
map({ "i", "n", "s", "x" }, "<C-s>", "<CMD>w<CR><ESC>", { desc = "Save buffer with Ctrl + s" })

-- Editing
--
-- Use Alt + j/k to move lines up/down
map("i", "<A-k>", "<ESC><CMD>m .-2<CR>==gi", { desc = "Move line(s) up" })
map("i", "<A-j>", "<ESC><CMD>m .+1<CR>==gi", { desc = "Move lines(s) down" })
map("n", "<A-k>", "<CMD>m .-2<CR>==", { desc = "Move line(s) up" })
map("n", "<A-j>", "<CMD>m .+1<CR>==", { desc = "Move line(s) down" })
map("v", "<A-k>", "<CMD>m '<-2<CR>gv=gv", { desc = "Move line(s) up" })
map("v", "<A-j>", "<CMD>m '>+1<CR>gv=gv", { desc = "Move line(s) down" })

-- Identing
map("n", ">", ">>", { desc = "Shift text to the right" })
map("n", "<", "<<", { desc = "Shift text to the left" })

map("v", ">", ">gv", { desc = "Shift text to the right" })
map("v", "<", "<gv", { desc = "Shift text to the left" })

-- Join line below to the current one and keep with one
-- space in-between the cursor at the beginning of the line
map("n", "J", "mzJ`z", { desc = "Join line below to the current one" })

-- Search & Replace
--
-- Keep the cursor at the same position
-- when searching word under it
map("n", "n", "nzzzv", { desc = "Repeat search in the same direction" })
map("n", "N", "Nzzzv", { desc = "Repeat search in the same direction (backward)" })

-- Registers
--
-- Paste over highlighted text and delete
-- the same from the void register
map("x", "<leader>v", '"_dP', { desc = "Paste without loosing current paste buffer" })
--
-- Copy text to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into the system clipboard register" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank into the system clipboard register" })

-- Misc
-- Better experience
map("n", "<space>", "<NOP>")
map("n", "Q", "<NOP>")
