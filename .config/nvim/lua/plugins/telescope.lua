return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
		},
		'nvim-telescope/telescope-ui-select.nvim',
	},
	config = function()
		local telescope = require 'telescope'
		local actions = require 'telescope.actions'
		local themes = require 'telescope.themes'

		telescope.setup {
			extensions = {
				['ui-select'] = {
					themes.get_dropdown(),
				},
			},
			defaults = {
				file_ignore_patterns = { 'node_modules' },
				mappings = {
					i = {
						['<esc>'] = actions.close,
					},
				},
			},
		}

		telescope.load_extension 'fzf'
		telescope.load_extension 'ui-select'
	end,
	keys = {
		{
			'<leader>sf',
			function()
				require('telescope.builtin').find_files()
			end,
			desc = '[S]earch [f]iles',
		},
		{
			'<leader>sh',
			function()
				require('telescope.builtin').help_tags()
			end,
			desc = '[S]earch [h]elp',
		},
		{
			'<leader>sg',
			function()
				require('telescope.builtin').live_grep()
			end,
			desc = '[S]earch [g]rep',
		},
		{
			'<leader>sw',
			require('telescope.builtin').grep_string,
			desc = '[S]earch for current [w]ord',
		},
		{
			'<leader>sd',
			require('telescope.builtin').diagnostics,
			desc = '[S]earch [d]iagnostics',
		},
		{
			'<leader>ss',
			require('telescope.builtin').lsp_document_symbols,
		},
		{
			'<leader>sk',
			require('telescope.builtin').keymaps,
			desc = '[S]earch [k]eymaps',
		},
	},
}
