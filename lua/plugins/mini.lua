return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            require('mini.splitjoin').setup({
                mappings = {
                    toggle = 'gS',
                    split = '',
                    join = '',
                },
            })
            local files = require('mini.files')
            files.setup()
            vim.keymap.set('n', '<leader>oo', function ()
                files.open()
            end)

        end,
    }

}
