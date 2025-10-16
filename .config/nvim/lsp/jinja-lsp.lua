vim.filetype.add({
	extension = {
		jinja = "jinja",
		jinja2 = "jinja",
		j2 = "jinja",
		["html.jinja"] = "jinja",
	},
})

print(vim.inspect(vim.filetype.match({ filename = "template.html" })))

return {
	cmd = { "jinja-lsp", "--stdio" },
	filetypes = { "jinja", "html" },
}
