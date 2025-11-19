vim.filetype.add({
	extension = {
		jinja = "jinja",
		jinja2 = "jinja",
		j2 = "jinja",
		["html.jinja"] = "jinja",
	},
})

return {
	cmd = { "jinja-lsp", "--stdio" },
	filetypes = { "jinja", "html" },
	root_markers = { ".git" },
}
