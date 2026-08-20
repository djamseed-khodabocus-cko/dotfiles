-- Roslyn LSP plugin
-- https://github.com/seblyng/roslyn.nvim

vim.pack.add({ 'https://github.com/seblyng/roslyn.nvim' })

require('roslyn').setup({
    filewatching = 'roslyn',
    lock_target = true,
})

vim.lsp.config('roslyn', {
    settings = {
        ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'fullSolution',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
        },
        ['csharp|formatting'] = {
            dotnet_organize_imports_on_format = true,
        },
        ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
        },
        ['csharp|symbol_search'] = {
            dotnet_search_reference_assemblies = true,
        },
    },
})
