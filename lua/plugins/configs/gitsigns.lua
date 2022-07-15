local present, gitsigns = pcall(require, 'gitsigns')
if not present then
    return
end

gitsigns.setup {
    on_attach = function(bufnr)
        require('mappings').gitsigns(gitsigns, bufnr)
    end,
    word_diff = true,
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 250,
    },
}
