local present, lspconfig = pcall(require, 'lspconfig')
if not present then
    return
end

local on_attach = function(client, bufnr)
    require('mappings').lsp(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
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

