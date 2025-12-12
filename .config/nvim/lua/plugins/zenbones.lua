return {
	"zenbones-theme/zenbones.nvim",
	lazy = false,
	priority = 1000,
	dependencies = "rktjmp/lush.nvim",
	config = function()
		vim.o.termguicolors = true
		vim.g.zenbones_darken_comments = 45
		vim.g.zenbones_transparent_background = true
		vim.cmd.colorscheme("zenbones")
	end,
}
