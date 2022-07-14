local M = {}

M.map = function(modes, key, cmd, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(modes, key, cmd, options)
end

return M
