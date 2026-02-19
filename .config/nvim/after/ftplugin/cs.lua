vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.cindent = true
vim.opt_local.smartindent = false -- Disable smartindent to prevent conflicts with cindent
vim.opt_local.formatoptions:append({ 'r', 'o' })

local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('dotnet_format', { clear = true })

autocmd('BufWritePost', {
  group = group,
  buffer = 0, -- Apply to the current buffer only
  callback = function()
    local file = vim.api.nvim_buf_get_name(0)
    vim.fn.jobstart({ 'dotnet', 'format', '--include', file }, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.schedule(function()
            vim.cmd('checktime')
          end)
        end
      end,
    })
  end,
})
