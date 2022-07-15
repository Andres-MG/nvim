local map = require('utils').map

map('n', '<Tab>', '<cmd> bnext <CR>')
map('n', '<S-Tab>', '<cmd> bprev <CR>')
map('n', '<leader>x', function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd('bprev')
    vim.cmd('bd' .. bufnr)
end)

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('i', '<C-h>', '<Left>')
map('i', '<C-j>', '<Down>')
map('i', '<C-k>', '<Up>')
map('i', '<C-l>', '<Right>')

map('n', '<leader>tt', function()
    if vim.opt.background:get() == 'dark' then
        vim.opt.background = 'light'
    else
        vim.opt.background = 'dark'
    end
end)

local M = {}

M.cmp = function(cmp)
    return {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-n>'] = {
            c = function(fallback)
               if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
        },
        ['<C-p>'] = {
            c = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
        },
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    }
end

M.gitsigns = function(gs, bufnr)
    local bufopts = { buffer = bufnr }
    map('n', '[c', gs.next_hunk, bufopts)
    map('n', ']c', gs.prev_hunk, bufopts)
    map({'n', 'v'}, '<leader>hs', gs.stage_hunk, bufopts)
    map({'n', 'v'}, '<leader>hr', gs.reset_hunk, bufopts)
    map('n', '<leader>hS', gs.stage_buffer, bufopts)
    map('n', '<leader>hu', gs.undo_stage_hunk, bufopts)
    map('n', '<leader>hR', gs.reset_buffer, bufopts)
    map('n', '<leader>hp', gs.preview_hunk, bufopts)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end, bufopts)
    map('n', '<leader>tb', gs.toggle_current_line_blame, bufopts)
    map('n', '<leader>hd', gs.diffthis, bufopts)
    map('n', '<leader>hD', function() gs.diffthis('~') end, bufopts)
    map('n', '<leader>td', gs.toggle_deleted, bufopts)
    map('n', '<leader>hl', gs.setloclist, bufopts)
end

M.hop = function()
    map('n', '<leader>s', '<cmd> HopChar1 <CR>')
    map('n', '<leader><leader>s', '<cmd> HopChar2 <CR>')
end

M.lsp = function(bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', 'gk', vim.lsp.buf.signature_help, bufopts)
    map('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    map('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    map('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map('n', '[d', vim.diagnostic.goto_prev, bufopts)
    map('n', ']d', vim.diagnostic.goto_next, bufopts)

end

M.nvim_tree = function()
    map('n', '<C-n>', '<cmd> NvimTreeToggle <CR>')
end

M.symbols_outline = function()
    map('n', '<leader>o', '<cmd> SymbolsOutline <CR>')
end

M.telescope = function(telescope)
    map('n', '<leader>ff', function() telescope.find_files() end)
    map('n', '<leader>fg', function() telescope.live_grep() end)
    map('n', '<leader>fb', function() telescope.buffers() end)
    map('n', '<leader>fh', function() telescope.help_tags() end)
    map('n', '<leader>fs', function() telescope.treesitter() end)
    map('n', '<leader>fk', function() telescope.keymaps() end)
    map('n', '<leader>dd', function() telescope.diagnostics() end)
    map('n', '<leader>gs', function() telescope.git_status() end)
    map('n', '<leader>gc', function() telescope.git_commits() end)
    map('n', '<leader>gb', function() telescope.git_branches() end)
    map('n', '<leader>gS', function() telescope.git_stash() end)
end

M.toggleterm = function()
    map('n', '<leader>tv', '<cmd> ToggleTerm size=80 direction=vertical <CR>')
    map('n', '<leader>th', '<cmd> ToggleTerm direction=horizontal <CR>')
    map('n', '<leader>tf', '<cmd> ToggleTerm direction=float <CR>')

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
        cmd = 'lazygit',
        direction = 'float',
        hidden = true,
    })
    map('n', '<leader>lg', function() lazygit:toggle() end)

    local htop = Terminal:new({
        cmd = 'htop',
        direction = 'float',
        hidden = true,
    })
    map('n', '<leader>ht', function() htop:toggle() end)
end

M.trouble = function()
    map('n', '<leader>xx', '<cmd> TroubleToggle <CR>')
    map('n', '<leader>xw', '<cmd> TroubleToggle workspace_diagnostics <CR>')
    map('n', '<leader>xd', '<cmd> TroubleToggle document_diagnostics <CR>')
    map('n', '<leader>xq', '<cmd> TroubleToggle quickfix <CR>')
    map('n', '<leader>xl', '<cmd> TroubleToggle loclist <CR>')
    map('n', '<leader>xr', '<cmd> TroubleToggle lsp_references <CR>')
end

return M
