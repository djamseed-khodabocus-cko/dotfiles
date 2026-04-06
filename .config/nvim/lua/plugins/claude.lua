-- Seamless integration between Claude Code and Neovim
-- https://github.com/greggh/claude-code.nvim

return {
    'greggh/claude-code.nvim',
    opts = {
        keymaps = {
            toggle = {
                normal = '<leader>ac', --toggle Claude Code
                terminal = '<leader>at', -- toggle CLaude code (terminal)
                variants = {
                    continue = '<leader>aC', -- Normal mode keymap for Claude Code with continue flag
                    verbose = '<leader>aV', -- Normal mode keymap for Claude Code with verbose flag
                },
            },
        },
    },
}
