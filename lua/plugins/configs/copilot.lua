vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
    ['*'] = false,
    ['julia'] = true,
    ['python'] = true,
    ['fortran'] = true,
    ['rust'] = true,
    ['c'] = true,
    ['c++'] = true,
}

require('mappings').copilot()