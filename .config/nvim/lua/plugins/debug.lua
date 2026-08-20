-- Debug Adapter Protocol client implementation for Neovim
-- https://github.com/mfussenegger/nvim-dap

vim.pack.add({
    { src = 'https://github.com/mfussenegger/nvim-dap' },
    { src = 'https://github.com/rcarriga/nvim-dap-ui' },
    { src = 'https://github.com/nvim-neotest/nvim-nio' },
    { src = 'https://github.com/theHamsta/nvim-dap-virtual-text' },
    { src = 'https://github.com/leoluz/nvim-dap-go' },
    { src = 'https://github.com/NicholasMata/nvim-dap-cs' },
})

local configured = false

local function configure()
    if configured then
        return
    end
    configured = true

    local dap = require('dap')
    local dapui = require('dapui')

    require('nvim-dap-virtual-text').setup({})

    dapui.setup({
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
            icons = {
                pause = '⏸',
                play = '▶',
                step_into = '⏎',
                step_over = '⏭',
                step_out = '⏮',
                step_back = 'b',
                run_last = '▶▶',
                terminate = '⏹',
                disconnect = '⏏',
            },
        },
    })

    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- .NET debugger setup (using nvim-dap-cs)
    require('dap-cs').setup({
        netcoredbg = {
            path = vim.fn.expand('~/.local/share/nvim/mason/packages/netcoredbg/libexec/netcoredbg/netcoredbg'),
        },
    })

    -- Go debugger setup
    require('dap-go').setup({
        delve = {
            path = vim.fn.expand('~/.local/share/nvim/mason/bin/dlv'),
        },
    })
end

-- Keymaps. Each one configures the stack before running, so whichever is pressed first works.
local map = function(keys, action, desc)
    vim.keymap.set('n', keys, function()
        configure()
        action()
    end, { desc = desc, silent = true })
end

map('<F5>', function() vim.cmd.DapContinue() end, 'Debug: Start/Continue')
map('<F7>', function() vim.cmd.DapStepInto() end, 'Debug: Step Into')
map('<F8>', function() vim.cmd.DapStepOver() end, 'Debug: Step Over')
map('<S-F8>', function() vim.cmd.DapStepOut() end, 'Debug: Step Out')
map('<F9>', function() require('dapui').toggle() end, 'Debug: See last session result')
map('<leader>bb', function() vim.cmd.DapToggleBreakpoint() end, 'Debug: Toggle Breakpoint')
map('<leader>bc', function() vim.cmd.DapClearBreakpoints() end, 'Debug: Clear all Breakpoints')
map(
    '<leader>B',
    -- There is no `:DapSetBreakpoint` command; the API call is the way to set a conditional one
    function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    'Debug: Set conditional Breakpoint'
)
