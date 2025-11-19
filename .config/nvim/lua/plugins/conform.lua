local formatters = {
	lua = { "stylua" },
	go = { "goimports", "golines", "gofumpt" },
	html = { "prettier", "djlint" },
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	css = { "prettier" },
	json = { "prettier" },
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
