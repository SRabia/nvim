return {
    {
        'tpope/vim-fugitive',
        vim.keymap.set("n", "<leader>gs", function()
            vim.cmd("vert Git")
        end)
    },
    {
        'sindrets/diffview.nvim'
    }
}
