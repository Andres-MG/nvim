local present, toggleterm = pcall(require, 'toggleterm')
if not present then
    return
end

toggleterm.setup {
    size = function(term)
        if term.direction == 'horizontal' then
            return 20
        elseif term.direction == 'vertical' then
            return vim.opt.columns:get() * 0.4
        end
    end,
    open_mapping = [[<C-\>]],
    direction = 'float',
    float_opts = {
        border = 'rounded',
    },
}

require('mappings').toggleterm()
