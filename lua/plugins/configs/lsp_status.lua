local present, lsp_status = pcall(require, 'lsp-status')
if not present then
    return
end

lsp_status.config {
    diagnostics = false,
    status_symbol = ' LSP'
}
