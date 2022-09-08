local present, symbols = pcall(require, 'symbols-outline')
if not present then
    return
end

require('mappings').symbols_outline()
symbols.setup {
    relative_width = true,
    width = 20,
}
