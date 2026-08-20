-- Automatic indentation style detection
-- https://github.com/NMAC427/guess-indent.nvim

vim.pack.add({ 'https://github.com/NMAC427/guess-indent.nvim' })

require('guess-indent').setup({
    auto_cmd = false,

    -- Excluded where the formatter enforces a canonical style that detection would fight:
    -- gofmt is always tabs. Everything else (cs, lua, sh, zig) has a per-project style worth
    -- matching -- and shfmt derives its own indent from 'shiftwidth', so it follows whatever
    -- is detected.
    filetype_exclude = { 'go', 'netrw', 'tutor' },
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('guess-indent-after-ftplugin', { clear = true }),
    desc = 'Detect indentation once ftplugin defaults are in place',
    callback = function(args)
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
                require('guess-indent').set_from_buffer(args.buf, true, true)
            end
        end)
    end,
})
