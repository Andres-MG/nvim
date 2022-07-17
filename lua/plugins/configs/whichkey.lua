local present, whichkey = pcall(require, 'which-key')
if not present then
    return
end

require('mappings').whichkey()

whichkey.setup()
