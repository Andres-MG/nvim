local present, cursorline = pcall(require, 'nvim-cursorline')
if not present then
    return
end

cursorline.setup {
    cursorline = {
        timeout = 250,
    },
}
