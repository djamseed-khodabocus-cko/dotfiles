-- Emacs Org mode rebuilt for Neovim: outlines, TODOs, agenda, capture, clocking, tables
-- https://github.com/xheisenbugx/org.nvim

vim.pack.add({ { src = 'https://github.com/xheisenbugx/org.nvim', version = vim.version.range('1.*') } })

local org_dir = vim.fn.expand('~/org')

require('org').setup({
    org_directory = org_dir,
    agenda_files = { org_dir .. '/journal/*.org', org_dir .. '/notes/*.org' },
    default_notes_file = org_dir .. '/refile.org',

    -- `!` (timestamp) rather than `@` (note): a note prompt blocks bulk agenda actions
    todo_keywords = { 'TODO(t) | DONE(d!) CANCELLED(x!)' },
    enforce_todo_dependencies = true,
    enforce_todo_checkbox_dependencies = true,

    -- A = today, B = default, C = when it happens
    priority_default = 'B',
    priority_lowest = 'C',

    log_done = 'time',
    log_redeadline = 'time',
    log_reschedule = 'time',
    log_into_drawer = 'LOGBOOK',

    startup_folded = 'content',
    use_property_inheritance = true,
    deadline_warning_days = 14,
    archive_location = org_dir .. '/archive/%s::datetree/',

    agenda = {
        span = 'week',
        start_on_weekday = 1,
        skip_scheduled_if_done = true,
        skip_deadline_if_done = true,
        skip_scheduled_if_deadline_is_shown = true,
        window = 'current',
    },

    capture = {
        templates = {
            t = { description = 'Task', template = '* TODO %?', empty_lines = 1 },
            n = { description = 'Note', template = '* %?', empty_lines = 1 },
        },
    },

    -- Within the current file only; there is no projects.org to refile into
    refile = {
        max_level = 2,
        include_current_file = true,
        use_outline_path = 'file',
        outline_path_complete_in_steps = false,
        allow_creating_parent_nodes = 'confirm',
    },

    ui = {
        todo_keyword_faces = { CANCELLED = { fg = '#6f6f6f', strikethrough = true } },
    },
})
