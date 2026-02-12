-- Neovim frontend for opencode
-- https://github.com/sudo-tee/opencode.nvim#-setting-up-opencode

return {
  'sudo-tee/opencode.nvim',
  event = 'LspAttach',
  config = function()
    require('opencode').setup({
      preferred_picker = 'fzf',
      preferred_completion = 'blink',
    })
  end,
}
