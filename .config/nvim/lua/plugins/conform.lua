return {
	'stevearc/conform.nvim',
	dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>f',
			function()
				require('conform').format { async = true }
			end,
			desc = '[F]ormat buffer',
		},
	},
	---@module 'conform'
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { 'stylua' },
			python = { 'ruff_fix', 'ruff_format' },
			javascript = { 'prettierd' },
			typescript = { 'prettierd' },
			javascriptreact = { 'prettierd' },
			typescriptreact = { 'prettierd' },
			css = { 'prettierd' },
			markdown = { 'prettierd' },
			go = { 'gofumpt' },
			typst = { 'typstyle' },
			sql = { 'sleek' },
		},
		default_format_opts = {
			lsp_format = 'fallback',
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = 'fallback',
		},
		notify_on_error = true,
		notify_no_formatters = true,
		--formatter options
		formatters = {},
	},
	config = function(_, opts)
		local tools_to_install = {}
		for _, tools in pairs(opts.formatters_by_ft) do
			for _, tool in ipairs(tools) do
				-- NOTE: this assumes that when the name of the tool contains an underscore, the first part is the tool name
				tool = vim.split(tool, '_')[1]
				if not vim.tbl_contains(tools_to_install, tool) then
					table.insert(tools_to_install, tool)
				end
			end
		end

		require('mason-tool-installer').setup {
			ensure_installed = tools_to_install,
			auto_update = true,
		}

		require('conform').setup(opts)
	end,
}
