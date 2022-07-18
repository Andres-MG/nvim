local present, gitsigns = pcall(require, 'gitsigns')
if not present then
    return
end

gitsigns.setup {
    on_attach = function()
        require('mappings').gitsigns(gitsigns)
    end,
    current_line_blame = false,
    current_line_blame_opts = {
        delay = 250,
    },
}
