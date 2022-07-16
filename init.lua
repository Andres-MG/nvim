local set = vim.opt
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

-- General
g.mapleader = ' '

-- Indenting
set.autoindent = true
set.expandtab = true
set.smarttab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

-- Numbers
set.number = true
set.relativenumber = true
set.numberwidth = 2

-- UI
set.title = true
set.clipboard = 'unnamedplus'
set.cursorline = true
set.mouse = 'a'
set.updatetime = 250
set.whichwrap:append '<>[]hl'
set.colorcolumn = { '100', '120' }
set.list = true
set.listchars:append('trail:⋅')
set.listchars:append('tab:> ')

-- Theme
set.termguicolors = true
set.background = 'dark'

-- Autocmds
autocmd(
    { 'Filetype' },
    {
        pattern  = 'gitcommit',
        callback = function()
            set.colorcolumn = { '50', '80' }
        end,
    }
)

autocmd(
    { 'Filetype' },
    {
        pattern = 'julia',
        callback = function()
            set.colorcolumn = '92'
        end,
    }
)

-- Packer && plugins
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    print 'Cloning packer ...'
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    require 'plugins'
    vim.cmd 'PackerSync'
end

require('packer').init {
    ensure_dependencies = true,
    compile_on_sync = true,
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    },
}

require 'plugins'
require 'plugins.lsp'
require 'mappings'
