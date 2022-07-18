local present, whichkey = pcall(require, 'which-key')
if not present then
    return
end

require('mappings').whichkey()

vim.opt.timeoutlen = 500

whichkey.setup()
