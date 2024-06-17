return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		settings = {
			save_on_toggle = true,
		},
	},
	keys = function()
		local keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "harpoon File",
			},
			{
				"<C-e>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon Quick Menu",
			},
		}
		table.insert(keys, {
			"<C-t>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "harpoon to file t",
		})

		table.insert(keys, {
			"<C-s>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "harpoon to file s",
		})
		table.insert(keys, {
			"<C-h>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "harpoon to file h",
		})
		table.insert(keys, {
			"<C-n>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "harpoon to file n",
		})
		return keys
	end,
}
