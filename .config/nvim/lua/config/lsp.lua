local servers = {
	"basedpyright",
	"gopls",
	"golangci_lint_ls",
	"lua_ls",
	"ruff",
	"rust_analyzer",
	"tailwindcss",
	"taplo",
	"ts_ls",
	"eslint",
	"jsonls",
}

vim.lsp.enable(servers)

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

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end
	end,
})
