vim.cmd 'packadd packer.nvim'

require('packer').startup(function(use)
    -- Packer --
    use 'wbthomason/packer.nvim'

    -- Theme --
    use {
        'rakr/vim-one',
        config = function()
            vim.cmd('colorscheme one')
        end,
    }

    -- Lsp --
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/nvim-lsp-installer',
            { 'hrsh7th/cmp-nvim-lsp', opt = true },
        },
        config = function()
            require('nvim-lsp-installer').setup {
                automatic_installation = true,
            }
            require 'plugins.configs.lspconfig'
        end,
    }

    -- Treesitter --
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true,
                },
            }
        end,
    }

    -- Autocompletion --
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
        config = function()
            require 'plugins.configs.cmp'
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

    -- Lualine --
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
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

    -- Julia --
    use 'JuliaEditorSupport/julia-vim'

    -- Gitsigns --
    use {
        'lewis6991/gitsigns.nvim',
        tag = 'release',
        config = function()
            require 'plugins.configs.gitsigns'
        end,
    }

    -- Github copilot --
    use 'github/copilot.vim'

    -- Toggleterm --
    use {
        'akinsho/toggleterm.nvim',
        tag = 'v2.*',
        config = function()
            require 'plugins.configs.toggleterm'
        end,
    }
end)
