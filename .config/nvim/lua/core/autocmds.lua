local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- check if we need to reload the buffer when it changed
autocmd({ 'CursorHold', 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('reload_buffer', { clear = true }),
  pattern = '*',
  command = 'checktime',
})

-- disable automatic comment continuation
autocmd('BufEnter', {
  group = augroup('disable_comment_continuation', { clear = true }),
  pattern = '*',
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

-- highlight text on yank
autocmd('TextYankPost', {
  group = augroup('highlight_yank', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      hlgroup = 'IncSearch',
      timeout = 100,
    })
  end,
})

-- wrap and check for spelling in text filetypes
autocmd('FileType', {
  group = augroup('wrap_spell', { clear = true }),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- go to the last known location when opening a buffer
autocmd('BufReadPost', {
  group = augroup('last_loc', { clear = true }),
  pattern = '*',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- toggle cursorline on/off
autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  group = augroup('cursorline_on', { clear = true }),
  pattern = '*',
  callback = function()
    vim.wo.cursorline = true
  end,
})

autocmd({ 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = augroup('cursorline_off', { clear = true }),
  pattern = '*',
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- toggle relativelinenumber on/off
autocmd('InsertEnter', {
  group = augroup('relativenumber_off', { clear = true }),
  pattern = '*',
  callback = function()
    vim.opt.relativenumber = false
  end,
})

autocmd('InsertLeave', {
  group = augroup('relativenumber_on', { clear = true }),
  pattern = '*',
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q', { clear = true }),
  pattern = {
    'help',
    'lspinfo',
    'notify',
    'qf',
    'checkhealth',
  },
  callback = function(evt)
    vim.bo[evt.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = evt.buf, silent = true })
  end,
})
