vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = {
    ['*'] = false,
    ['julia'] = true,
    ['python'] = true,
    ['fortran'] = true,
    ['rust'] = true,
    ['c'] = true,
    ['c++'] = true,
}
vim.g.copilot_node_command = "/home/andres/Software/node-v12.17.0-linux-x64/bin/node"

require('mappings').copilot()
