local present, cmp = pcall(require, 'cmp')
if not present then
    return
end

vim.opt.completeopt = { 'menuone', 'noselect' }

cmp.setup {
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert(require('mappings').cmp(cmp)),
    sources = cmp.config.sources({
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lsp' },
    }),
}

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'buffer' },
    }),
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'cmdline' },
        { name = 'path' },
    }),
})
