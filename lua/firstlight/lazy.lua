-- Setup lazy.nvim
require("lazy").setup({
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Rose-pine colorscheme
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        name='tokyonight',
        priority = 1000,
        opts = {},
    },
    -- Miasma colorscheme
    -- {
        --     "xero/miasma.nvim",
        --     name = 'miasma',
        --     lazy = false,
        --      priority = 1000,
        -- },
        -- Treesitter
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate'
        },
        'nvim-treesitter/playground',

        -- Navigation and utilities
        {
            'ThePrimeagen/harpoon',
            branch = 'harpoon2',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        'tpope/vim-fugitive',
        'mbbill/undotree',

        -- Inline errors
        {
            "rachartier/tiny-inline-diagnostic.nvim",
            event = "VeryLazy",
            priority = 1000,
            config = function()
                require("tiny-inline-diagnostic").setup()
                vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
            end,
        },
        -- LSP Zero and related plugins
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v4.x',
            dependencies = {
                -- LSP Support
                'neovim/nvim-lspconfig',
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',

                -- Autocompletion
                'hrsh7th/nvim-cmp',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'saadparwaiz1/cmp_luasnip',

                -- Snippets
                'L3MON4D3/LuaSnip',
                'rafamadriz/friendly-snippets',
            }
        },
    }, {
        -- lazy.nvim configuration options
        ui = {
            border = "rounded",
        },
    })
