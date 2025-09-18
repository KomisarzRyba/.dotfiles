return {
	'stevearc/oil.nvim',
	lazy = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
	},
	keys = {
		{
			'-',
			':Oil<CR>',
			mode = 'n',
			desc = 'Toggle file explorer',
		},
	},
}
