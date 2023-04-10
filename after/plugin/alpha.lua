local function header()
    return {
        [[          _____                    _____                    _____          ]],
        [[         /\    \                  /\    \                  /\    \         ]],
        [[        /::\    \                /::\    \                /::\    \        ]],
        [[       /::::\    \              /::::\    \              /::::\    \       ]],
        [[      /::::::\    \            /::::::\    \            /::::::\    \      ]],
        [[     /:::/\:::\    \          /:::/\:::\    \          /:::/\:::\    \     ]],
        [[    /:::/__\:::\    \        /:::/__\:::\    \        /:::/__\:::\    \    ]],
        [[    \:::\   \:::\    \       \:::\   \:::\    \       \:::\   \:::\    \   ]],
        [[  ___\:::\   \:::\    \    ___\:::\   \:::\    \    ___\:::\   \:::\    \  ]],
        [[ /\   \:::\   \:::\    \  /\   \:::\   \:::\    \  /\   \:::\   \:::\    \ ]],
        [[/::\   \:::\   \:::\____\/::\   \:::\   \:::\____\/::\   \:::\   \:::\____\]],
        [[\:::\   \:::\   \::/    /\:::\   \:::\   \::/    /\:::\   \:::\   \::/    /]],
        [[ \:::\   \:::\   \/____/  \:::\   \:::\   \/____/  \:::\   \:::\   \/____/ ]],
        [[  \:::\   \:::\    \       \:::\   \:::\    \       \:::\   \:::\    \     ]],
        [[   \:::\   \:::\____\       \:::\   \:::\____\       \:::\   \:::\____\    ]],
        [[    \:::\  /:::/    /        \:::\  /:::/    /        \:::\  /:::/    /    ]],
        [[     \:::\/:::/    /          \:::\/:::/    /          \:::\/:::/    /     ]],
        [[      \::::::/    /            \::::::/    /            \::::::/    /      ]],
        [[       \::::/    /              \::::/    /              \::::/    /       ]],
        [[        \::/    /                \::/    /                \::/    /        ]],
        [[         \/____/                  \/____/                  \/____/         ]],
    }
end

local function footer()
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y"
    local plugins_text = "\t" .. total_plugins .. " plugins " .. datetime

    --Quote
    local quote = "Triple Super Extreme. Ultimate coding danger! 3x the best,\n" ..
                    "3rank, 3x world champion in all categories"

    return plugins_text .. "\n" .. quote

end

local dashboard = require "alpha.themes.dashboard"
local alpha = require "alpha"

dashboard.section.header.val = header()

dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}


dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Constant"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Function"
dashboard.section.buttons.opts.hl_shortcut = "Type"
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
