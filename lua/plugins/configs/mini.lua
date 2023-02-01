-- Mini.pairs --
local ppairs, autopairs = pcall(require, 'mini.pairs')
if ppairs then
    autopairs.setup {}
end

-- Mini.comment --
local pcomment, comment = pcall(require, 'mini.comment')
if pcomment then
    comment.setup {}
end

-- Mini.indentscope --
local pindent, indent = pcall(require, 'mini.indentscope')
if pindent then
    indent.setup{
        draw = {
            animation = indent.gen_animation.none()
        },
        symbol = '',
    }
end

-- Mini.jump --
local pjump, jump = pcall(require, 'mini.jump')
if pjump then
    jump.setup {}
end

-- Mini.move --
local pmove, move = pcall(require, 'mini.move')
if pmove then
    move.setup {}
end

-- Mini.surround --
local psurround, surround = pcall(require, 'mini.surround')
if psurround then
    surround.setup {}
end

-- Mini.tabline --
local ptabline, tabline = pcall(require, 'mini.tabline')
if ptabline then
    tabline.setup {}
end

-- Mini.trailspace --
local ptrailspace, trailspace = pcall(require, 'mini.trailspace')
if ptrailspace then
    trailspace.setup {}
    vim.api.nvim_create_autocmd(
    { 'BufWritePost' },
    {
        group = 'UserConfig',
        callback = function()
            trailspace.trim()
            trailspace.trim_last_lines()
        end,
    }
    )
end
