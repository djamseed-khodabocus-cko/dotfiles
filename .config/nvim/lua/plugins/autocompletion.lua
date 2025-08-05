-- Performant, batteries-included completion plugin for Neovim
-- https://github.com/Saghen/blink.cmp

return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'giuxtaposition/blink-cmp-copilot',
  },
  event = 'LspAttach',
  version = '*',
  opts = {
    appearance = {
      nerd_font_variant = 'normal',
      use_nvim_cmp_as_default = false,
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = false, window = { border = 'rounded', scrollbar = false } },
      ghost_text = { enabled = false },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= 'cmdline' or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
        end,
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                if ctx.source_name == 'copilot' then
                  return '' -- Copilot icon
                else
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end
              end,
            },
          },
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'kind' },
          },
        },
        scrollbar = false,
        scrolloff = 1,
      },
    },
    keymap = {
      -- https://cmp.saghen.dev/configuration/keymap.html#default
      preset = 'default',
      ['<C-space>'] = {},
      ['<C-a>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },
    signature = { enabled = true, window = { border = 'rounded', show_documentation = true } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = 100,
          async = true,
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
