vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use ('wbthomason/packer.nvim')
    use {'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-live-grep-args.nvim'}
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    }
    use ('navarasu/onedark.nvim')

    use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use( 'nvim-treesitter/playground')
    use( 'ThePrimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use( 'ThePrimeagen/vim-be-good')
    -- Terminal
    use {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup()
        end,
    }


    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- Startup screen
    use {
        "goolord/alpha-nvim",
    }
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      -- opt = true,
      -- event = "InsertEnter",
      -- module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("nvim-autopairs").setup()
      end,
    }

end)

