return {
	"shaunsingh/nord.nvim",
	lazy = false,
	priority = 1000, -- load first
	config = function()
		vim.cmd([[colorscheme nord]])
	end,
}
