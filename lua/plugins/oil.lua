return {
	"stevearc/oil.nvim",
	opts = {},
	config = function()
		require("oil").setup({
			use_default_keymaps = false,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<leader>os"] = {"actions.select", opts = {vertical = true}, desc = "Open the entry in vertical"},
				["<leader>ov"] = {"actions.select", opts = {horizontal = true}, desc = "Open the entry in horizontal"},
				["<leader>ot"] = {"actions.select", opts = {tab = true}, desc = "Open the entry in new tab"},
				["<leader>op"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			view_options = {
				show_hidden = true,
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
			},
			is_always_hidden = function(name, bufnr)
				return false
			end,
		})
		vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory with oil" })
	end,
}
