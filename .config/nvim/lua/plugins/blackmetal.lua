return {
	"metalelf0/black-metal-theme-neovim",
	lazy = false,
	priority = 1000,
	config = function()
		local bm = require("black-metal")
		bm.setup({
			theme = "gorgoroth",
			transparent = true,
		})
		bm.load()
	end,
}
