local set = vim.opt
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General
g.mapleader = ','

-- Search
set.smartcase = true
set.incsearch = true

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
set.lazyredraw = true
set.scrolloff = 4
set.signcolumn = 'yes'

-- Theme
set.termguicolors = true
set.background = 'dark'

set.guifont = { 'Iosevka', ':h10' }

-- Spellcheck
set.spelllang = 'en'

-- Autocmds
augroup('UserConfig', {
    clear = true,
})
autocmd(
    { 'Filetype' },
    {
        group = 'UserConfig',
        pattern  = 'gitcommit',
        callback = function()
            set.colorcolumn = { '50', '80' }
        end,
    }
)

autocmd(
    { 'Filetype' },
    {
        group = 'UserConfig',
        pattern = 'julia',
        callback = function()
            set.colorcolumn = '92'
        end,
    }
)

-- Disable builtin vim plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "matchit",
}
for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- Packer && plugins
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    print 'Cloning packer ...'
    Packer_bootstrap = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
end

autocmd(
    { 'BufWritePost' },
    {
        group = 'UserConfig',
        pattern = 'plugins.lua',
        command = 'source <afile> | PackerCompile',
    }
)

require 'plugins'
require 'plugins.lsp'
require 'plugins.copilot'
require 'mappings'
