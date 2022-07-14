local present, lspconfig = pcall(require, 'lspconfig')
if not present then
    return
end

local on_attach = function(client, bufnr)
    require('mappings').lsp(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- LSP servers --

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilites = capabilities,
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

