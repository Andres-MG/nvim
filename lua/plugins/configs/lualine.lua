local present, lualine = pcall(require, 'lualine')
if not present then
    return
end

local lsp = {
    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
}

lualine.setup {
    options = {
        theme = 'auto',
    },
    extensions = {
        'nvim-tree',
        'symbols-outline',
    },
    sections = {
        lualine_x = {'encoding', 'fileformat', 'filetype', lsp},
    },
}
