--- Terraform language server
--- https://github.com/hashicorp/terraform-ls

vim.filetype.add({ extension = { tf = 'terraform' } })

return {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'terraform-vars' },
    root_markers = { '.terraform', '.git', 'iac' },
    settings = {
        terraform = {
            format = {
                enable = true,
            },
        },
    },
}
