-- Debug Adapter Protocol client implementation for Neovim
-- https://github.com/mfussenegger/nvim-dap

return {
	'mfussenegger/nvim-dap',
	dependencies = {
		-- A UI for nvim-dap
		{ 'rcarriga/nvim-dap-ui' },
		-- Asynchronous IO librady, required by nvim-dap-ui
		{ 'nvim-neotest/nvim-nio', lazy = true },
		-- Bridges gaps between mason and nvim-dap
		{ 'jay-babu/mason-nvim-dap.nvim', lazy = true },
		-- Adds virtual text support for nvim-dap
		{ 'theHamsta/nvim-dap-virtual-text', lazy = true },

		-- Debugger extensions
		{ 'leoluz/nvim-dap-go', ft = 'go' },
		{ 'mfussenegger/nvim-dap-python', ft = 'python' },
	},
	event = 'VeryLazy',
	config = function()
		local dap = require('dap')
		local dapui = require('dapui')
		local keymap = require('core.utils').keymap

		require('mason-nvim-dap').setup({
			automatic_installation = true,
			automatic_setup = true,
			handlers = {}, -- Can provide additional configuration to handlers
			ensure_installed = { -- Update debuggers here based on the language being used
				'delve', -- Go debugger
				'netcoredbg', -- .NET debugger
				'python', -- Python debugger
			},
		})

		require('nvim-dap-virtual-text').setup()

		dapui.setup({
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				icons = {
					pause = '⏸',
					play = '▶',
					step_into = '⏎',
					step_over = '⏭',
					step_out = '⏮',
					step_back = 'b',
					run_last = '▶▶',
					terminate = '⏹',
					disconnect = '⏏',
				},
			},
		})

		vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close

		keymap('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
		keymap('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
		keymap('n', '<F8>', dap.step_over, { desc = 'Debug: Step Over' })
		keymap('n', '<S-F8>', dap.step_out, { desc = 'Debug: Step Out' })
		keymap('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
		keymap('n', '<leader>B', dap.set_breakpoint, { desc = 'Debug: Set Breakpoint' })
		keymap('n', '<leader>bc', dap.clear_breakpoints, { desc = 'Debug: Clear all Breakpoints' })
		keymap('n', '<F9>', dapui.toggle, { desc = 'Debug: See last session result' })

		-- .NET debugger setup
		dap.adapters.coreclr = {
			type = 'executable',
			command = vim.fn.expand('~/.local/share/nvim/mason/packages/netcoredbg/libexec/netcoredbg/netcoredbg'),
			args = { '--interpreter=vscode' },
		}

		dap.adapters.netcoredbg = {
			type = 'executable',
			command = vim.fn.expand('~/.local/share/nvim/mason/packages/netcoredbg/libexec/netcoredbg/netcoredbg'),
			args = { '--interpreter=vscode' },
		}

		dap.configurations.cs = {
			{
				type = 'coreclr',
				name = 'Launch - netcoredbg',
				request = 'launch',
				program = function()
					return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
				end,
			},
		}

		-- Go debugger setup
		require('dap-go').setup({
			delve = {
				path = vim.fn.expand('~/.local/share/nvim/mason/bin/dlv'),
			},
		})

		-- Python debugger setup
		require('dap-python').setup(vim.fn.expand('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'))

		-- Zig debugger setup (using LLDB)
		dap.adapters.lldb = {
			type = 'executable',
			command = vim.fn.expand('/usr/bin/lldb'),
			name = 'lldb',
		}
		dap.configurations.zig = {
			{
				name = 'Launch',
				type = 'lldb',
				request = 'launch',
				program = function()
					return vim.fn.input('Path to executable', vim.fn.getcwd() .. '/zig-out/bin', 'file')
				end,
			},
		}
	end,
}
