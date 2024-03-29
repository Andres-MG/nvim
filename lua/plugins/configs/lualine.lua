local present, lualine = pcall(require, 'lualine')
if not present then
    return
end

local present_lsp_status, lsp_status = pcall(require, 'lsp-status')

local lsp
if present_lsp_status then
    lsp = {
        function()
            -- Check if copilot is active
            local copilot = false
            for _, client in ipairs(vim.lsp.buf_get_clients(0)) do
                if client.name == 'copilot' then
                    copilot = true
                    break
                end
            end
            -- Skip it if so
            local msg = lsp_status.status()
            local minbufs = 0
            if copilot then
                msg = msg .. '🛸 '
                minbufs = 1
            end
            if #vim.lsp.buf_get_clients(0) > minbufs then
                return msg
            end
            return ''
        end,
    }
else
    lsp = {
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
end

lualine.setup {
    options = {
        theme = 'auto',
    },
    extensions = {
        'nvim-tree',
        'symbols-outline',
        'toggleterm',
    },
    sections = {
        lualine_x = {'encoding', 'fileformat', 'filetype', lsp},
    },
    tabline = {
        lualine_a = {'buffers'},
        lualine_z = {'tabs'},
    }
}
