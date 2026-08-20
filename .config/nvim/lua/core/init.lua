-- Disable built-in runtime plugins natively
local disabled_builtins = {
    '2html_plugin',
    'bugreport',
    'compiler',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logiPat',
    'matchit',
    'matchparen',
    'netrw',
    'netrwFileHandlers',
    'netrwPlugin',
    'optwin',
    'remote_plugins',
    'rplugin',
    'rrhelper',
    'spellfile_plugin',
    'synmenu',
    'tar',
    'tarPlugin',
    'tohtml',
    'tutor',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
}

for _, plugin in ipairs(disabled_builtins) do
    vim.g['loaded_' .. plugin] = 1
end

vim.g.mapleader = ' '
vim.g.nerd_fonts = true

require('core.options')
require('core.keymaps')
require('core.autocmds')
require('core.lsp')
