-- Load every Lua file in the plugins directory. `vim.fs.dir` yields entries in filesystem order,
-- so sort them: some modules depend on an earlier one having run (lualine needs the colorscheme's
-- theme to be on the runtimepath, for instance).
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'plugins')
local modules = {}
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
    if (type == 'file' or type == 'link') and file_name:match('%.lua$') and file_name ~= 'init.lua' then
        table.insert(modules, (file_name:gsub('%.lua$', '')))
    end
end
table.sort(modules)

for _, module in ipairs(modules) do
    require('plugins.' .. module)
end

local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
        local stderr = result.stderr or ''
        local stdout = result.stdout or ''
        local output = stderr ~= '' and stderr or stdout
        if output == '' then
            output = 'No output from build command.'
        end
        vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
end

-- Autocommands that run after a plugin is installed or updated
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(event)
        local name = event.data.spec.name
        local kind = event.data.kind
        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        -- Treesitter
        if name == 'nvim-treesitter' then
            if not event.data.active then
                vim.cmd.packadd('nvim-treesitter')
            end
            vim.cmd('TSUpdate')
            return
        end

        -- Build Rust fuzzy matching binary for blink.cmp
        if name == 'blink.cmp' and vim.fn.executable('cargo') == 1 then
            run_build(name, { 'cargo', 'build', '--release' }, event.data.path)
            return
        end
    end,
})
