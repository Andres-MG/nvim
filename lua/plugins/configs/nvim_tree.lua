local present, nvim_tree = pcall(require, 'nvim-tree')
if not present then
    return
end

nvim_tree.setup()

require('mappings').nvim_tree()
