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

        -- Supermaven
         {
            "supermaven-inc/supermaven-nvim",
            config = function()
                require("supermaven-nvim").setup({
                    disable_inline_completion = true,  -- use cmp instead of ghost text
                    disable_keymaps = true,            -- let cmp handle <Tab>
                })
            end,
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

        -- Mason tool installer (auto-installs formatters/linters via Mason)
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            dependencies = { "williamboman/mason.nvim" },
            event = "VeryLazy",
            opts = {
                ensure_installed = {
                    "ruff",       -- Python format + organize imports
                    "stylua",     -- Lua
                    "goimports",  -- Go imports
                    "gofumpt",    -- Go (stricter gofmt)
                    "prettier",   -- JS/TS/JSON/CSS/HTML
                },
            },
        },

        -- Conform (formatting)
        {
            "stevearc/conform.nvim",
            event = { "BufWritePre" },
            cmd = { "ConformInfo" },
            keys = {
                {
                    "<leader>f",
                    function()
                        require("conform").format({ async = true, lsp_format = "fallback" })
                    end,
                    mode = { "n", "v" },
                    desc = "Format buffer",
                },
            },
            opts = {
                formatters_by_ft = {
                    python = { "ruff_organize_imports", "ruff_format" },
                    lua = { "stylua" },
                    go = { "goimports", "gofumpt" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    json = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                },
                format_on_save = function(bufnr)
                    -- Allow disabling autoformat per-buffer or globally
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return { timeout_ms = 500, lsp_format = "fallback" }
                end,
            },
        },

        -- Lualine (statusline)
        {
            "nvim-lualine/lualine.nvim",
            event = "VeryLazy",
            dependencies = { "nvim-tree/nvim-web-devicons", "ThePrimeagen/harpoon" },
            config = function()
                -- Custom harpoon component: shows marks 1-N, highlighting the
                -- one matching the current buffer.
                local function harpoon_component()
                    local ok, harpoon = pcall(require, "harpoon")
                    if not ok then
                        return ""
                    end
                    local list = harpoon:list()
                    local total = list:length()
                    if total == 0 then
                        return ""
                    end

                    local current = vim.api.nvim_buf_get_name(0)
                    local root = vim.uv.cwd() or vim.loop.cwd()
                    local parts = {}
                    for i = 1, total do
                        local item = list:get(i)
                        local value = item and item.value or ""
                        local abs = vim.fs.normalize(root .. "/" .. value)
                        if vim.fs.normalize(current) == abs then
                            parts[#parts + 1] = "[" .. i .. "]"
                        else
                            parts[#parts + 1] = tostring(i)
                        end
                    end
                    return "󰛢 " .. table.concat(parts, " ")
                end

                require("lualine").setup({
                    options = {
                        theme = "auto",
                        globalstatus = true,
                        section_separators = "",
                        component_separators = "",
                    },
                    sections = {
                        lualine_c = {
                            "filename",
                            { harpoon_component, color = { gui = "bold" } },
                        },
                    },
                })
            end,
        },

        -- Todo-comments (highlight & search TODO/FIX/HACK/etc.)
        {
            "folke/todo-comments.nvim",
            event = "VeryLazy",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {},
            keys = {
                { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
                {
                    "]t",
                    function() require("todo-comments").jump_next() end,
                    desc = "Next todo comment",
                },
                {
                    "[t",
                    function() require("todo-comments").jump_prev() end,
                    desc = "Previous todo comment",
                },
            },
        },

        -- Which-key (popup showing available keybindings)
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {},
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        },
    }, {
        -- lazy.nvim configuration options
        ui = {
            border = "rounded",
        },
    })
