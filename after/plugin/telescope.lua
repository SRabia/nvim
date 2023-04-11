local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps',function()
	builtin.grep_string({search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', 'gr', builtin.lsp_references, {desc = '[G]oto to [R]eference'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = '[f]ind []buffer'})
