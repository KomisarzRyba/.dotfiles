return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{ "<leader>tod", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
	},
}
