--- Terraform language server
--- https://github.com/hashicorp/terraform-ls
return {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'tf', 'tfvars' },
  root_markers = { '.terraform', '.git', 'iac' },
  settings = {
    terraform = {
      format = {
        enable = true,
      },
    },
  },
}
