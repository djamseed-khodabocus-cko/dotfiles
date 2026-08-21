-- Set lualine as statusline
-- https://github.com/nvim-lualine/lualine.nvim
-- Inspired by https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/plugins/lualine.lua

vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

local mode = {
    'mode',
    fmt = function(str)
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        return ' ' .. str
    end,
}

local filename = {
    'filename',
    file_status = true, -- displays file status (readonly status, modified status)
    path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
}

local hide_in_width = function() return vim.fn.winwidth(0) > 100 end

local diagnostics = {
    'diagnostics',
    always_visible = false,
    colored = false,
    cond = hide_in_width,
    sections = { 'error', 'warn' },
    sources = { 'nvim_diagnostic', 'nvim_lsp' },
    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
    update_in_insert = false,
}

local diff = {
    'diff',
    colored = false,
    cond = hide_in_width,
    symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
}

local async_progress = function() return vim.ui.progress_status() or '' end

require('lualine').setup({
    options = {
        always_divide_middle = true,
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'snacks_picker_input', 'snacks_dashboard', 'snacks_explorer' },
        globalstatus = true,
        icons_enabled = true,
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = '', right = '' },
        theme = 'oxocarbon',
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = {
            filename,
            'filesize',
            'lsp_status',
            async_progress,
        },
        lualine_x = {
            diagnostics,
            diff,
            'fileformat',
            { 'encoding', fmt = string.upper, cond = hide_in_width },
            { 'filetype', cond = hide_in_width },
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
