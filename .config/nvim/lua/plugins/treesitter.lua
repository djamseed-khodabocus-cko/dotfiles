-- Parser and syntax highlighter
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'nvim-treesitter.configs', -- sets main module to use for opts
  opts = {
    auto_install = true,
    ensure_installed = {
      'bash',
      'c',
      'c_sharp',
      'css',
      'diff',
      'dockerfile',
      'go',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'rust',
      'textproto',
      'toml',
      'typescript',
      'typst',
      'vim',
      'vimdoc',
      'yaml',
      'zig',
    },
    sync_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = '+',
        scope_incremental = false,
        node_decremental = '-',
      },
    },
    textobjects = {
      select = {
        enable = true,
        -- automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- can also use the capture groups defined in textobjects.scm
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ap'] = '@parameter.outer',
          ['ip'] = '@parameter.inner',
        },
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@parameter.inner'] = 'v',
          ['@function.outer'] = 'v',
          ['@class.outer'] = '<C-v>',
        },
        include_surrounding_whitespace = false,
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  },
}
