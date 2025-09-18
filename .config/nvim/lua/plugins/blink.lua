return {
	'saghen/blink.cmp',
	lazy = false,
	dependencies = 'rafamadriz/friendly-snippets',
	version = 'v0.*',
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'super-tab',
		},
		appearance = {
			nerd_font_variant = 'mono',
		},
		signature = { enabled = true },
	},
}
