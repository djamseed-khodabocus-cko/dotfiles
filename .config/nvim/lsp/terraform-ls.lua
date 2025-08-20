--- Terraform language server
--- https://github.com/hashicorp/terraform-ls
return {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
  settings = {
    terraform = {
      format = {
        enable = true,
      },
    },
  },
}
