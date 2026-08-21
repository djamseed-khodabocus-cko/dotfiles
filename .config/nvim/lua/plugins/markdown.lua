-- Render markdown in the buffer while editing it
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })

require('render-markdown').setup({
    -- No latex parser and no utftex/latex2text converter installed
    latex = { enabled = false },
})
