vim.cmd 'packadd packer.nvim'

require('packer').startup {
    function(use)
        -- Impatient--
        use {
            'lewis6991/impatient.nvim',
            config = function()
                require 'impatient'
            end,
        }
        -- Packer --
        use 'wbthomason/packer.nvim'

        -- Theme --
        use {
            'Th3Whit3Wolf/one-nvim',
            config = function()
                vim.cmd('colorscheme one-nvim')
            end,
        }

        -- Treesitter --
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = 'p00f/nvim-ts-rainbow',
            run = ':TSUpdate',
            config = function()
                require 'plugins.configs.treesitter'
            end,
        }

        -- Telescope --
        use {
            'nvim-telescope/telescope.nvim',
            requires = 'nvim-lua/plenary.nvim',
            tag = '0.1.0',
            config = function()
                require 'plugins.configs.telescope'
            end
        }

        -- Nvim-tree --
        use {
            'kyazdani42/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup()
            end,
        }

        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require 'plugins.configs.nvim_tree'
            end,
        }

        -- LSP
        use {
            'neovim/nvim-lspconfig',
            'williamboman/nvim-lsp-installer',
            'simrat39/rust-tools.nvim',
            -- Config goes after all the plugins are loaded
        }

        -- Autocompletion --
        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lsp-signature-help',
                'onsails/lspkind.nvim',
            },
            config = function()
                require 'plugins.configs.cmp'
            end,
        }

        -- Autopairs --
        use {
            'windwp/nvim-autopairs',
            config = function()
                require("nvim-autopairs").setup {}
            end,
        }

        -- Lualine --
        use {
            'nvim-lua/lsp-status.nvim',
            config = function()
                require 'plugins.configs.lsp_status'
            end,
        }

        use {
            'nvim-lualine/lualine.nvim',
            requires = 'nvim-web-devicons',
            after = 'lsp-status.nvim',
            config = function()
                require 'plugins.configs.lualine'
            end,
        }

        -- Bufferline --
        use {
            'akinsho/bufferline.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            tag = 'v2.*',
            config = function()
                require 'plugins.configs.bufferline'
            end
        }

        -- Comments --
        use {
            'numToStr/Comment.nvim',
            keys = { 'gc', 'gb' },
            config = function()
                require('Comment').setup()
            end,
        }

        -- Notifications --
        use {
            'rcarriga/nvim-notify',
            config = function()
                require 'plugins.configs.notify'
            end,
        }

        -- Symbols list --
        use {
            'simrat39/symbols-outline.nvim',
            config = function()
                require 'plugins.configs.symbols_outline'
            end,
        }

        -- Hop --
        use {
            'phaazon/hop.nvim',
            branch = 'v2',
            config = function()
                require 'plugins.configs.hop'
            end,
        }

        -- Trailing spaces --
        use {
            'lewis6991/spaceless.nvim',
            event = 'InsertEnter',
            config = function()
                require('spaceless').setup()
            end,
        }

        -- Indenting lines --
        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('indent_blankline').setup()
            end,
        }

        -- Scrollbar --
        use {
            'petertriho/nvim-scrollbar',
            config = function()
                require('scrollbar').setup()
            end,
        }

        -- Julia --
        use {
            'JuliaEditorSupport/julia-vim',
            event = 'InsertEnter',
            -- lazy-loading for filetypes already in the plugin
            -- https://github.com/JuliaEditorSupport/julia-vim/issues/35
        }

        -- Gitsigns --
        use {
            'lewis6991/gitsigns.nvim',
            tag = 'release',
            config = function()
                require 'plugins.configs.gitsigns'
            end,
        }

        -- Trouble --
        use {
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require 'plugins.configs.trouble'
            end,
        }

        -- Github copilot --
        use {
            'github/copilot.vim',
            event = 'InsertEnter',
        }

        -- Toggleterm --
        use {
            'akinsho/toggleterm.nvim',
            tag = 'v2.*',
            config = function()
                require 'plugins.configs.toggleterm'
            end,
        }

        -- Which-key
        use {
            'folke/which-key.nvim',
            config = function()
                require 'plugins.configs.whichkey'
          end,
        }
        -- Sync after bootstrap
        if Packer_bootstrap then
            print 'Syncing packer ...'
            require('packer').sync()
        end
    end,
    config = {
        ensure_dependencies = true,
        compile_on_sync = true,
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'rounded' })
            end,
        },
    },
}
