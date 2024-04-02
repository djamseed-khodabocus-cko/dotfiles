local M = {}

---@param mode string|table
---@param lhs string|table
---@param rhs string|function
---@param opts table | nil
function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.keymap.set(mode, lhs, rhs, options)
end

---@param event string|table
---@param group string
---@param opts table
---@param command string|function
function M.autocmd(event, group, opts, command)
	opts.group = vim.api.nvim_create_augroup("user_" .. group, { clear = true })

	if type(command) == "function" then
		opts.callback = command
	else
		opts.command = command
	end

	vim.api.nvim_create_autocmd(event, opts)
end

return M
