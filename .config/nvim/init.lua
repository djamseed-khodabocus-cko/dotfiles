-- Improve startup performance
vim.loader.enable()

-- Enable experimental presentation layer for messages and command-line
local ok, ui2 = pcall(require, 'vim._core.ui2')

if ok then
    ui2.enable({
        enable = true,
        msg = {
            targets = 'cmd',
            cmd = { height = 0.5 },
            dialog = { height = 0.5 },
            msg = { height = 0.5, timeout = 4500 },
            pager = { height = 1 },
        },
    })
end

require('core')
require('plugins')
