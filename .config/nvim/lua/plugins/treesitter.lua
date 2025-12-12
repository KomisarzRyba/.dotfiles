return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua" },
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			highlight = {
				enable = true,
			},
			modules = {},
		})
	end,
}
