return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
			config = function()
				require("telescope").load_extension("ui-select")
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local themes = require("telescope.themes")

		telescope.setup({
			extensions = {
				["ui-select"] = {
					themes.get_dropdown(),
				},
			},
			defaults = {
				file_ignore_patterns = { "node_modules" },
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
			},
		})
	end,
	keys = {
		{
			"<leader>sf",
			"<cmd>Telescope find_files<cr>",
			desc = "[S]earch [f]iles",
		},
		{
			"<leader>sh",
			"<cmd>Telescope help_tags<cr>",
			desc = "[S]earch [h]elp",
		},
		{
			"<leader>sg",
			"<cmd>Telescope live_grep<cr>",
			desc = "[S]earch [g]rep",
		},
		{
			"<leader>sw",
			"<cmd>Telescope grep_string<cr>",
			desc = "[S]earch for current [w]ord",
		},
		{
			"<leader>sd",
			"<cmd>Telescope diagnostics<cr>",
			desc = "[S]earch [d]iagnostics",
		},
		{
			"<leader>ss",
			"<cmd>Telescope lsp_document_symbols<cr>",
			desc = "[S]earch [s]ymbols in current buffer",
		},
		{
			"<leader>sk",
			"<cmd>Telescope keymaps<cr>",
			desc = "[S]earch [k]eymaps",
		},
	},
}
