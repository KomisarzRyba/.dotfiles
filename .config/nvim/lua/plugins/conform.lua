local formatters = {
	lua = { "stylua" },
	go = { "goimports", "golines", "gofumpt" },
	html = { "superhtml fmt" },
}

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = formatters,
		format_on_save = {
			lsp_fallback = true,
			async = false,
		},
	},
}
