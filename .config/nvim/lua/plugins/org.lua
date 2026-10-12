-- Emacs Org mode rebuilt for Neovim: outlines, TODOs, agenda, capture, clocking, tables
-- https://github.com/xheisenbugx/org.nvim

vim.pack.add({ { src = 'https://github.com/xheisenbugx/org.nvim', version = vim.version.range('1.*') } })

local org_dir = vim.fn.expand('~/org')

-- Today's roam daily note, created with the same header roam gives it (title + file ID) so a
-- plain capture into it still leaves a roam node
local function today_daily()
    local day = os.date('%Y-%m-%d')
    local path = org_dir .. '/journal/' .. day .. '.org'
    if vim.fn.filereadable(path) == 0 then
        local id = require('org.id').new_id()
        vim.fn.writefile({ ':PROPERTIES:', ':ID:       ' .. id, ':END:', '#+title: ' .. day, '' }, path)
    end
    return path
end

require('org').setup({
    org_directory = org_dir,
    agenda_files = { org_dir .. '/inbox/*.org', org_dir .. '/journal/*.org', org_dir .. '/notes/*.org' },
    default_notes_file = org_dir .. '/inbox/tasks.org',

    -- `!` (timestamp) rather than `@` (note): a note prompt blocks bulk agenda actions
    todo_keywords = { 'TODO(t) WAITING(w!) SOMEDAY(s) | DONE(d!) CANCELLED(x!)' },
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
            -- Used by the weekly review when it finishes (%i is its summary)
            w = { description = 'Weekly review', template = '* Weekly review %U\n%i%?', target = today_daily },
        },
    },

    -- Targets: the agenda files (inbox, journal, notes) and the current file, two levels deep
    refile = {
        max_level = 2,
        include_current_file = true,
        use_outline_path = 'file',
        outline_path_complete_in_steps = false,
        allow_creating_parent_nodes = 'confirm',
    },

    extensions = {
        super_agenda = {
            groups = {
                { name = 'Today', time_grid = true, scheduled = 'today', deadline = 'today' },
                { name = 'Overdue', scheduled = 'past', deadline = 'past' },
                { name = 'Important', priority = 'A' },
                { name = 'Due soon', deadline = 'future' },
                { auto_category = true, order = 9 },
            },
        },
        quickadd = {},
        review = { capture_template = 'w' },
        sidebar = {},
        timeline = {},
        heatmap = {},
        -- Rooted at ~/org so inbox, dailies and notes share one index; top-level files and the
        -- archive stay out of it. New nodes land in inbox/ and move to notes/ once processed
        roam = {
            directory = org_dir,
            exclude = {
                'data/',
                'archive/',
                function(relpath) return not relpath:find('/', 1, true) end,
            },
            capture_templates = {
                d = {
                    description = 'default',
                    type = 'plain',
                    template = '%?',
                    target = 'inbox/${slug}.org',
                    head = '#+title: ${title}\n',
                    unnarrowed = true,
                },
            },
            capture_ref_templates = {
                r = {
                    description = 'ref',
                    type = 'plain',
                    template = '%?',
                    target = 'inbox/${slug}.org',
                    head = '#+title: ${title}\n',
                    unnarrowed = true,
                },
            },
            extract_new_file_path = 'notes/${slug}.org',
            dailies = { directory = 'journal/' },
        },
    },

    -- <C-Space> is the tmux prefix
    mappings = {
        org = { toggle_checkbox = '<leader>o<Space>' },
    },

    ui = {
        bullets = { '◉', '○', '✸', '✿' },
        checkboxes = { ' ', '◐', '✓' },
        hide_leading_stars = true,
        -- oxocarbon links TODO to the same pink as level-1 headlines, so give it its own face
        todo_keyword_faces = {
            TODO = { fg = '#ff7eb6', bold = true },
            WAITING = { fg = '#be95ff', bold = true },
            SOMEDAY = { fg = '#78a9ff', bold = true },
            DONE = { fg = '#42be65', bold = true },
            CANCELLED = { fg = '#6f6f6f', strikethrough = true },
        },
    },
})

-- oxocarbon maps scheduled, overdue and upcoming deadlines to the same purple, and leaves the
-- now-line and priorities uncoloured. org only sets these groups when they are undefined.
local function agenda_highlights()
    local hls = {
        OrgAgendaHeader = { fg = '#78a9ff', bold = true },
        OrgAgendaScheduled = { fg = '#42be65' },
        OrgAgendaScheduledPast = { fg = '#ee5396' },
        OrgAgendaDeadline = { fg = '#ee5396', bold = true },
        OrgAgendaDeadlineUpcoming = { fg = '#be95ff' },
        OrgAgendaCurrentTime = { fg = '#33b1ff', bold = true },
        OrgAgendaPriorityHighest = { fg = '#ee5396', bold = true },
    }
    for name, hl in pairs(hls) do
        vim.api.nvim_set_hl(0, name, hl)
    end
end

agenda_highlights()
vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('org-agenda-highlights', { clear = true }),
    callback = agenda_highlights,
})
