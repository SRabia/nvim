require('lualine').setup {
    options = {
        theme = 'auto',
        icons_enabled = false,
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
    },
    sections = {
        lualine_c = { {'filename', path=1, file_status = true } },
    },
    inactive_sections = {
        lualine_c = { {'filename', path=1, file_status = true } },
    }

}

require('lualine').setup()

