vim.filetype.add({
	extension = {
		html = "html",
	},
})

return {
	cmd = { "superhtml", "lsp" },
	filetypes = { "html" },
}
