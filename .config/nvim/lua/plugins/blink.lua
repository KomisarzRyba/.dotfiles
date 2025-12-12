return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "super-tab" },
		completion = { documentation = { auto_show = true } },
		sources = {
			default = { "lsp", "snippets", "buffer", "path" },
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
