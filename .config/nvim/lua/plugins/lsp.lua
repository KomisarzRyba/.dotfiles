local servers = {
	-- lua
	lua_ls = {},

	-- rust
	rust_analyzer = {},

	-- c
	clangd = {},

	-- python
	pyright = {
		settings = {
			pyright = {
				-- Using Ruff's import organizer
				disableOrganizeImports = true,
			},
			-- python = {
			--   analysis = {
			--     -- Ignore all files for analysis to exclusively use Ruff for linting
			--     ignore = { '*' },
			--   },
			-- },
		},
	},
	ruff = {},

	-- go
	gopls = {
		settings = {
			gopls = {
				gofumpt = true,
			},
		},
	},

	-- zig
	zls = {
		settings = {
			zls = {
				enable_build_on_save = true,
				build_on_save_step = 'check',
			},
		},
	},

	-- ts
	ts_ls = {},

	-- html
	html = {},

	-- toml
	taplo = {
		_on_setup = function()
			return {
				root_dir = require('lspconfig.util').root_pattern('*.toml', '.git'),
			}
		end,
	},

	-- json
	jsonls = {
		filetypes = { 'json', 'jsonc' },
	},

	-- typst
	tinymist = {
		filetypes = { 'typst', 'typ' },
		settings = {
			tinymist = {
				rootPath = vim.loop.cwd(),
				exportPdf = "onType",
			}
		},
	},

	-- docker
	docker_language_server = {},
}


local function disable_ruff_hover()
	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup(
			'lsp_attach_disable_ruff_hover',
			{ clear = true }
		),
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client == nil then
				return
			end
			if client.name == 'ruff' then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end
		end,
		desc = 'LSP: Disable hover capability from Ruff',
	})
end

local function configure_symbol_highlighting()
	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
		callback = function(attach_args)
			local client = vim.lsp.get_client_by_id(attach_args.data.client_id)
			if
					not client or not client.server_capabilities.documentHighlightProvider
			then
				return
			end

			local hl_augroup =
					vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				buffer = attach_args.buf,
				group = hl_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = attach_args.buf,
				group = hl_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd('LspDetach', {
				group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
				callback = function(detach_args)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds {
						group = 'lsp-highlight',
						buffer = detach_args.buf,
					}
				end,
			})
		end,
		desc = 'LSP: Set up highlight on cursor hold',
	})
end

return {
	'neovim/nvim-lspconfig',
	event = 'BufEnter',
	dependencies = {
		{
			'folke/lazydev.nvim',
			opts = {
				library = {
					os.getenv 'HOME' .. '/.local/share/lua/love2d/library',
					{ path = '${3rd}/luv/library', words = { 'vim%.uv ' } },
				},
			},
		},
		{ 'williamboman/mason.nvim', config = true },
		'williamboman/mason-lspconfig.nvim',
		'saghen/blink.cmp',
		'nvim-telescope/telescope.nvim',
	},
	config = function()
		local lspconfig = require 'lspconfig'
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend(
			'force',
			capabilities,
			require('blink.cmp').get_lsp_capabilities()
		)

		require('mason').setup()
		require('mason-lspconfig').setup {
			automatic_enable = true,
			automatic_installation = false,
			ensure_installed = vim.tbl_keys(servers or {}),
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					vim.notify(
						'Setting up LSP server: ' .. server_name,
						vim.log.levels.WARN
					)

					if server._on_setup then
						vim.notify(
							'Running _on_setup for ' .. server_name,
							vim.log.levels.WARN
						)
						vim.tbl_extend('force', server, server._on_setup())
					end

					server.capabilities = server.capabilities or capabilities
					lspconfig[server_name].setup(server)
				end,
			},
		}

		configure_symbol_highlighting()
		disable_ruff_hover()
	end,
	keys = {
		{
			'gd',
			function()
				require('telescope.builtin').lsp_definitions()
			end,
			desc = '[G]o to [d]efinition',
		},
		{
			'gr',
			function()
				require('telescope.builtin').lsp_references()
			end,
			desc = '[G]o to [r]eferences',
		},
		{
			'<leader>rn',
			vim.lsp.buf.rename,
			desc = '[R]e[n]ame',
		},
		{
			'K',
			vim.lsp.buf.hover,
			desc = 'Hover documentation',
		},
		{
			'<leader>e',
			vim.diagnostic.open_float,
			desc = 'Show diagnostic [e]rror messages',
		},
		{
			'<leader>ca',
			vim.lsp.buf.code_action,
			desc = '[C]ode [a]ction',
		},
		{
			'[d',
			function()
				vim.diagnostic.jump { count = -1, float = true }
			end,
			desc = 'Go to previous [d]iagnostic',
		},
		{
			']d',
			function()
				vim.diagnostic.jump { count = 1, float = true }
			end,
			desc = 'Go to next [d]iagnostic',
		},
	},
}
