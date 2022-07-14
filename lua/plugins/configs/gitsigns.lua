local present, gitsigns = pcall(require, 'gitsigns')
if not present then
    return
end

gitsigns.setup {
    on_attach = function(bufnr)
        require('mappings').gitsigns(gitsigns, bufnr)
    end,
}
