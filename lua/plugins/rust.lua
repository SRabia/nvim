return {
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				tools = {},
				server = {
					on_attach = function(client, bufnr) end,
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
							diagnostics = {
								enable = true,
							},
						},
					},
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup({
				lsp = {
					enabled = true,
					on_attach = function(client, bufnr) end,
					actions = true,
					completion = true,
					hover = true,
				},
				completion = {
					crates = {
						enabled = true,
						max_results = 8,
						min_chars = 3,
					},
				},
			})
			crates.show()
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
}
