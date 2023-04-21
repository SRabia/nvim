local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {desc = '[S]earch [F]ile'})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>gr',function()
	builtin.grep_string({search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', 'gr', builtin.lsp_references, {desc = '[G]oto to [R]eference'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = '[F]ind [B]uffer'})
