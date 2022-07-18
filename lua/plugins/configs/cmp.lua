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
    view = {
        entries = { name = 'custom', selection_order = 'near_cursor' }
    },
    mapping = cmp.mapping.preset.insert(require('mappings').cmp(cmp)),
    sources = cmp.config.sources({
        { name = 'buffer' },
        { name = 'path' },
    }, {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
    }),
}

local present_kind, lspkind = pcall(require, 'lspkind')
if present_kind then
    cmp.setup {
        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol_text',
                menu = ({
                    buffer = '[Buffer]',
                    path = '[Path]',
                    nvim_lsp = '[LSP]',
                }),
            }),
        },
    }
end

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

