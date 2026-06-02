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

        -- Claude Code
        {
            "coder/claudecode.nvim",
            dependencies = { "folke/snacks.nvim" }, -- for the floating terminal; optional but nicer
            config = true,
            keys = {
                { "<leader>c",  nil,                              desc = "AI/Claude" },
                { "<leader>cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
                { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
                { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
                { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
                { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
                { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                 desc = "Send selection" },
                {
                    "<leader>cs",
                    "<cmd>ClaudeCodeTreeAdd<cr>",
                    desc = "Add file from tree",
                    ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
                },
                -- Diff management
                { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
                { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
            },
        },

        -- Snacks (floating terminal backend for claudecode, etc.)
        {
            "folke/snacks.nvim",
            opts = {},
        },
    }, {
        -- lazy.nvim configuration options
        ui = {
            border = "rounded",
        },
    })
