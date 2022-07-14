local present, bufferline = pcall(require, 'bufferline')
if not present then
    return
end

bufferline.setup {
    options = {
        mode = 'buffers',
        numbers = 'none',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
        diagnostics = 'nvim_lsp',
        offsets = {
            {
                filetype = 'NvimTree',
                text = '',
                highlight = 'Directory',
                text_align = 'left',
            },
        },
    }
}
