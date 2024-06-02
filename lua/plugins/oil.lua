return {
	"stevearc/oil.nvim",
	opts = {},
	config = function()
		require("oil").setup({
			is_always_hidden = function(name, bufnr)
				return true
			end,
			use_default_keymaps = false,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<leader>os>"] = "actions.select_vsplit",
				["<leader>ov>"] = "actions.select_split",
				["<leader>ot>"] = "actions.select_tab",
				["<leader>op>"] = "actions.select_preview",
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
		})
		vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory with oil" })
	end,
}
