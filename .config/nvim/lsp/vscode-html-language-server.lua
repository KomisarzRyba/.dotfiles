vim.filetype.add({
	extension = {
		html = "html",
	},
})

return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
}
