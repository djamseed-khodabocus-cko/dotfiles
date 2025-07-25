local M = {}

---@param lhs string
---@param rhs string|function
---@param opts table|nil
---@param mode string|table|nil
function M.keymap(lhs, rhs, opts, mode)
	mode = mode or 'n'
	opts = opts or {}
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

---@param event string|table
---@param group string
---@param opts table
---@param command string|function
function M.autocmd(event, group, opts, command)
	opts.group = vim.api.nvim_create_augroup('user_' .. group, { clear = true })
	if type(command) == 'function' then
		opts.callback = command
	else
		opts.command = command
	end
	vim.api.nvim_create_autocmd(event, opts)
end

return M
