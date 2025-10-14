local function get_server_names()
	local server_dir = vim.fn.stdpath("config") .. "/lsp"
	if not vim.fn.isdirectory(server_dir) then
		return {}
	end

	local server_names = {}

	for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
		local server_name = vim.fn.fnamemodify(f, ":t:r")
		table.insert(server_names, server_name)
	end

	return server_names
end

local diagnostics_config = {
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
}

vim.lsp.enable(get_server_names())
vim.diagnostic.config(diagnostics_config)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local nmap = function(keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end
			vim.keymap.set("n", keys, func, {
				buffer = event.buf,
				desc = desc,
			})
		end

		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
		nmap("<leader>e", vim.diagnostic.open_float, "Show Error Message")
		nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
		nmap("[d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic")
		nmap("]d", vim.diagnostic.goto_next, "Go to Next Diagnostic")

		local telescope = require("telescope.builtin")
		nmap("gd", telescope.lsp_definitions, "Go to Definition")
		nmap("gr", telescope.lsp_references, "Go to References")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local hl_augroup = vim.api.nvim_create_augroup("lsp-hl", { clear = false })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = hl_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = hl_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(detach_event)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({
						group = hl_augroup,
						buffer = detach_event.buf,
					})
				end,
			})
		end
	end,
})
