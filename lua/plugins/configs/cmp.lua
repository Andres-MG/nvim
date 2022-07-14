local present, cmp = pcall(require, 'cmp')
if not present then
    return
end

vim.opt.completeopt = { 'menuone', 'noselect' }

cmp.setup {
    mapping = cmp.mapping.preset.insert(require('mappings').cmp(cmp)),
    sources = {
        { name = 'nvim_lua' },
        { name = 'nvim-lsp' },
        { name = 'nvim-lsp-signature-help' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmdline' },
    },
}
