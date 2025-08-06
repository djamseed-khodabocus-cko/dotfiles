-- Extend and create a/i textobjects
-- https://github.com/echasnovski/mini.ai

return {
  'echasnovski/mini.ai',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local ai = require('mini.ai')

    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        -- Treesitter-based textobjects for functions, classes, parameters
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
        a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
      },
    })
  end,
}
