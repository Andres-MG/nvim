-- Nothing to do if we are not using the LSP
local present_lsp, lspconfig = pcall(require, 'lspconfig')
if not present_lsp then
    return
end

-- LSP installer setup
local present_lsp_installer, lsp_installer = pcall(require, 'nvim-lsp-installer')
if present_lsp_installer then
    lsp_installer.setup {
        automatic_installation = true,
        ui = {
            border = 'rounded',
        },
    }
end

-- LSP status init
local present_lsp_status, lsp_status = pcall(require, 'lsp-status')
if present_lsp_status then
    lsp_status.register_progress()
end

-- On_attach function
local on_attach = function(client, bufnr)
    require('mappings').lsp()
    if present_lsp_status then
        lsp_status.on_attach(client)
    end
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
if present_lsp_status then
    capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
end
local present_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if present_cmp then
    capabilities = cmp_lsp.update_capabilities(capabilities)
end

-- LSP servers --

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
                enable = false
            },
        },
    },
}

lspconfig.julials.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.fortls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- UI --

-- Gutter LSP hings
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Borders for all LSP floats
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Borders for LspInfo float
local win = require 'lspconfig.ui.windows'
local _default_opts = win.default_opts
win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = 'rounded'
    return opts
end
