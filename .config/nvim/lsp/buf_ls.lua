-- Buf's LSP for Proto files
-- https://github.com/bufbuild/buf

vim.filetype.add({
    filename = {
        ['buf.yaml'] = 'buf-config',
        ['buf.gen.yaml'] = 'buf-config',
        ['buf.policy.yaml'] = 'buf-config',
        ['buf.lock'] = 'buf-config',
    },
})

return {
    cmd = { 'buf', 'lsp', 'serve', '--log-format=text' },
    filetypes = { 'proto', 'buf-config' },
    root_markers = { 'buf.yaml', '.git' },
    reuse_client = function(client, config) return client.name == config.name end,
}
