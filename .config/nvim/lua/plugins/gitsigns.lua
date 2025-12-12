return {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	keys = function()
		return {
			{
				"]c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						require("gitsigns").nav_hunk("next")
					end
				end,
				desc = "Next [c]hange",
			},
			{
				"[c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						require("gitsigns").nav_hunk("prev")
					end
				end,
				desc = "Previous [c]hange",
			},
			{
				"<leader>hs",
				require("gitsigns").stage_hunk,
				mode = "n",
				desc = "[h]unk [s]tage",
			},
			{
				"<leader>hr",
				require("gitsigns").reset_hunk,
				mode = "n",
				desc = "[h]unk [r]eset",
			},
			{
				"<leader>hs",
				function()
					require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "[h]unk [s]tage",
			},
			{
				"<leader>hr",
				function()
					require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "[h]unk [r]eset",
			},
			{
				"<leader>hS",
				require("gitsigns").stage_buffer,
				desc = "[S]tage buffer",
			},
			{
				"<leader>hu",
				require("gitsigns").stage_hunk,
				desc = "[h]unk [u]ndo stage",
			},
			{
				"<leader>hR",
				require("gitsigns").reset_buffer,
				desc = "[h]unk [R]eset buffer",
			},
			{
				"<leader>hp",
				require("gitsigns").preview_hunk,
				desc = "[h]unk [p]review",
			},
			{
				"<leader>hb",
				function()
					require("gitsigns").blame_line({ full = true })
				end,
				desc = "[h]unk [b]lame",
			},
			{
				"<leader>tb",
				require("gitsigns").toggle_current_line_blame,
				desc = "[t]oggle [b]lame",
			},
			{
				"<leader>hd",
				require("gitsigns").diffthis,
				desc = "[h]unk [d]iff",
			},
			{
				"<leader>hD",
				function()
					require("gitsigns").diffthis("~")
				end,
				desc = "[h]unk [D]iff",
			},
			{
				"<leader>td",
				require("gitsigns").toggle_deleted,
				desc = "[t]oggle [d]eleted",
			},
		}
	end,
	config = true,
}
