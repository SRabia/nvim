local builtin = require('telescope.builtin')

local telescope = require('telescope')
local lga_actions = require('telescope-live-grep-args.actions')

telescope.setup {
    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disalbe autoquaoting
            --define mapping e,g.
            mapping = {
                i = {
                    ['<C-k>'] = lga_actions.quote_prompt(),
                    ['<C-i>'] = lga_actions.quote_prompt({ postfix = "--iglob"}),
                },
            },
        }
    }
}
vim.keymap.set('n', '<leader>sf', builtin.find_files, {desc = '[S]earch [F]ile'})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ggr',function()
	builtin.grep_string({search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', 'gr', builtin.lsp_references, {desc = '[G]oto to [R]eference'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = '[F]ind [B]uffer'})

vim.keymap.set('n', '<leader>gr', require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true })
