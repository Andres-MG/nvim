local present, lspconfig = pcall(require, 'lspconfig')
if not present then
    return
end

-- LSP-status init
local present_lsp_status, lsp_status = pcall(require, 'lsp-status')
if present_lsp_status then
    lsp_status.register_progress()
end

-- On_attach function
local on_attach = function(client, bufnr)
    require('mappings').lsp(bufnr)
    if present_lsp_status then
        lsp_status.on_attach(client)
    end
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local present_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if present_cmp then
    capabilities = cmp_lsp.update_capabilities(capabilities)
end
if present_lsp_status then
    capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
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

