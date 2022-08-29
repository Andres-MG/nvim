local map = require('utils').map

map('n', '<Tab>', '<cmd> bnext <CR>', { desc = '  Next buffer' })
map('n', '<S-Tab>', '<cmd> bprev <CR>', { desc = '  Prev buffer' })
map('n', 'ds', function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd('bprev')
    vim.cmd('bd' .. bufnr)
end, { desc = '  Close buffer' })

map('n', '<A-h>', '<cmd> nohlsearch <CR>', { desc = '  No highlight search' })

map('n', '<C-h>', '<C-w>h', { desc = '  Left window' })
map('n', '<C-j>', '<C-w>j', { desc = '  Bottom window' })
map('n', '<C-k>', '<C-w>k', { desc = '  Top window' })
map('n', '<C-l>', '<C-w>l', { desc = '  Right window' })

map('n', '<C-Up>', ':resize -2<CR>', { desc = '  Resize up' })
map('n', '<C-Down>', ':resize +2<CR>', { desc = '  Resize down' })
map('n', '<C-Left>', ':vertical resize -2<CR>', { desc = '  Resize left' })
map('n', '<C-Right>', ':vertical resize +2<CR>', { desc = '  Resize right' })

map('i', '<C-h>', '<Left>', { desc = '  Move cursor left' })
map('i', '<C-j>', '<Down>', { desc = '  Move cursor down' })
map('i', '<C-k>', '<Up>', { desc = '  Move cursor up' })
map('i', '<C-l>', '<Right>', { desc = '  Move cursor right' })

map('n', '<leader>tt', function()
    if vim.o.background == 'dark' then
        vim.opt.background = 'light'
    else
        vim.opt.background = 'dark'
    end
end, { desc = '  Toggle theme' })

map('n', '<A-s>', function()
    vim.opt.spell = not vim.o.spell
end, { desc = '  Toggle spell checks' })

map('n', '<A-r>', function()
    vim.opt.relativenumber = not vim.o.relativenumber
end, { desc = '  Toggle relative line numbers' })

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

M.copilot = function()
    map('i', '<C-b>', 'copilot#Accept("<CR>")', { desc = '  Accept suggestion', expr = true })
end

M.gitsigns = function(gs)
    map('n', '[c', gs.next_hunk, { desc = '  Go to next hunk' })
    map('n', ']c', gs.prev_hunk, { desc = '  Go to prev hunk' })
    map({'n', 'v'}, '<leader>hs', gs.stage_hunk, { desc = '  Stage hunk' })
    map({'n', 'v'}, '<leader>hr', gs.reset_hunk, { desc = '  Reset hunk' })
    map('n', '<leader>hS', gs.stage_buffer, { desc = '  Stage buffer' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = '  Undo stage hunk' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = '  Reset buffer' })
    map('n', '<leader>hp', gs.preview_hunk, { desc = '  Preview hunk' })
    map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = '  Blame line' })
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '  Toggle line blame' })
    map('n', '<leader>hd', gs.diffthis, { desc = '  Diff this' })
    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = '  Diff this (~)' })
    map('n', '<leader>td', gs.toggle_deleted, { desc = '  Toggle deleted' })
    map('n', '<leader>hl', gs.setloclist, { desc = '  Set loclist' })
end

M.hop = function()
    map('n', '<leader>s', '<cmd> HopChar1 <CR>', { desc = '  Hop to one char' })
    map('n', '<leader><leader>s', '<cmd> HopChar2 <CR>', { desc = '  Hop to two chars' })
end

M.lsp = function()
    map('n', 'gd', vim.lsp.buf.definition, { desc = '  LSP definitions' })
    map('n', 'gD', vim.lsp.buf.declaration, { desc = '  LSP declarations' })
    map('n', 'K', vim.lsp.buf.hover, { desc = '  LSP hover' })
    map('n', 'gk', vim.lsp.buf.signature_help, { desc = '  LSP signature help' })
    map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '  LSP rename' })
    map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '  LSP code actions' })
    map('n', '<leader>f', vim.lsp.buf.formatting, { desc = '  LSP format' })
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '  LSP add workspace' })
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '  LSP remove workspace' })
    map('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = '  LSP list workspaces' })
    map('n', '<leader>d', function() vim.diagnostic.open_float({focus = false}) end, { desc = '  LSP open diagnostic' })
    map('n', '[d', vim.diagnostic.goto_prev, { desc = '  LSP go to next' })
    map('n', ']d', vim.diagnostic.goto_next, { desc = '  LSP go to prev' })

    if package.loaded.trouble then
        -- map('n', 'gd', '<cmd> TroubleToggle lsp_definitions <CR>')
        map('n', 'gr', '<cmd> TroubleToggle lsp_references <CR>', { desc = '  LSP references' })
        map('n', 'gi', '<cmd> TroubleToggle lsp_implementations <CR>', { desc = '  LSP implementations' })
        map('n', 'gt', '<cmd> TroubleToggle lsp_type_definitions <CR>', { desc = '  LSP type definitions' })
    else
        -- map('n', 'gd', vim.lsp.buf.definition, { desc = '  LSP definitions' })
        map('n', 'gr', vim.lsp.buf.references, { desc = '  LSP references' })
        map('n', 'gi', vim.lsp.buf.implementation, { desc = '  LSP implementations' })
        map('n', 'gt', vim.lsp.buf.type_definition, { desc = '  LSP type definitions' })
    end
end

M.nvim_tree = function()
    map('n', '<C-n>', '<cmd> NvimTreeToggle <CR>', { desc = 'פּ  Toggle NvimTree' })
end

M.rust = function(rt)
    map('n', '<leader>rs', function() rt.inlay_hints.set() end, { desc = '  Rust set hints' })
    map('n', '<leader>ru', function() rt.inlay_hints.unset() end, { desc = '  Rust unset hints' })
    map('n', '<leader>ra', function() rt.hover_actions.hover_actions() end, { desc = '  Rust hover actions' })
    map('n', '<leader>rg', function() rt.code_action_group.code_action_group() end, { desc = '  Rust code action '})
end

M.symbols_outline = function()
    map('n', '<C-s>', '<cmd> SymbolsOutline <CR>', { desc = 'פּ  Toggle symbols outline' })
end

M.telescope = function(telescope)
    map('n', '<leader>ff', function() telescope.find_files() end, { desc = '  Search files' })
    map('n', '<leader>fg', function() telescope.live_grep() end, { desc = '  Live grep' })
    map('n', '<leader>fb', function() telescope.buffers() end, { desc = '  Search buffers' })
    map('n', '<leader>fh', function() telescope.help_tags() end, { desc = '  Search help tags' })
    map('n', '<leader>fs', function() telescope.treesitter() end, { desc = '  Search treesitter' })
    map('n', '<leader>fk', function() telescope.keymaps() end, { desc = '  Search keymaps' })
    map('n', '<leader>fd', function() telescope.diagnostics() end, { desc = '  Search diagnostics' })
    map('n', '<leader>gs', function() telescope.git_status() end, { desc = '  Git status' })
    map('n', '<leader>gc', function() telescope.git_commits() end, { desc = '  Git commits' })
    map('n', '<leader>gb', function() telescope.git_branches() end, { desc = '  Git branches' })
    map('n', '<leader>gS', function() telescope.git_stash() end, { desc = '  Git stashes' })
end

M.toggleterm = function()
    map('n', '<C-t>', '<cmd> exe v:count1 . "ToggleTerm" <CR>', { desc = '  Toggle terminal' })
    map('t', '<C-t>', '<cmd> exe v:count1 . "ToggleTerm" <CR>', { desc = '  Toggle terminal' })
    map('n', '<leader>th', '<cmd> ToggleTerm size=80 direction=vertical <CR>', { desc = '  Horizontal terminal' })
    map('n', '<leader>tv', '<cmd> ToggleTerm direction=horizontal <CR>', { desc = '  Vertical terminal' })
    map('n', '<leader>tf', '<cmd> ToggleTerm direction=float <CR>', { desc = '  Floating terminal' })

    map('t', '<C-x>', '<C-\\><C-n>', { desc = '  Leave terminal mode' })

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })
    local htop = Terminal:new({cmd = 'htop', hidden = true})

    map('n', '<leader>lg', function() lazygit:toggle() end, { desc = '  Lazygit' })
    map('n', '<leader>ht', function() htop:toggle() end, { desc = '  Htop'})
end

M.trouble = function()
    map('n', '<leader>xx', '<cmd> TroubleToggle <CR>', { desc = 'ﱔ  Open Trouble'})
    map('n', '<leader>xw', '<cmd> TroubleToggle workspace_diagnostics <CR>', { desc = 'ﱔ  Show workspace diagnostics' })
    map('n', '<leader>xd', '<cmd> TroubleToggle document_diagnostics <CR>', { desc = 'ﱔ  Show document diagnostics' })
    map('n', '<leader>xq', '<cmd> TroubleToggle quickfix <CR>', { desc = 'ﱔ  Show quickfix' })
    map('n', '<leader>xl', '<cmd> TroubleToggle loclist <CR>', { desc = 'ﱔ  Show loclist' })
end

M.whichkey = function()
    map('n', '<leader>wk', '<cmd> WhichKey <CR>', { desc = '  Which-key all keymaps' })
    map('n', '<leader>wK', function()
        local input = vim.fn.input 'Which-key: '
        vim.cmd('WhichKey ' .. input)
    end, { desc = '  Which-key look-up key' })
end

return M
