-- MODE DISPLAY AND HIGHLIGHT
local function mode_name()
    local mode = vim.api.nvim_get_mode().mode
    local modes = {
        n = { "NORMAL", "StatusModeNormal" },
        i = { "INSERT", "StatusModeInsert" },
        v = { "VISUAL", "StatusModeVisual" },
        V = { "V-LINE", "StatusModeVisual" },
        [""] = { "V-BLOCK", "StatusModeVisual" },
        c = { "COMMAND", "StatusModeCommand" },
        R = { "REPLACE", "StatusModeReplace" },
        t = { "TERMINAL", "StatusModeTerminal" },
    }

    local info = modes[mode] or { "UNKNOWN", "StatusModeUnknown" }
    return string.format("%%#%s#%s %%*", info[2], info[1])
end

-- GIT BRANCH DISPLAY + STATUS CHECK
local function git_branch_status()
    local branch = vim.fn.FugitiveHead()
    if branch == "" then return "" end

    local handle = io.popen("git rev-list --left-right --count origin/" .. branch .. "..." .. branch .. " 2>/dev/null")
    if not handle then return " " end

    local result = handle:read("*a")
    handle:close()

    local behind, ahead = result:match("(%d+)%s+(%d+)")
    behind = tonumber(behind) or 0
    ahead = tonumber(ahead) or 0

    local hl_group = "GitBranchUpToDate"
    if behind > 0 then
        hl_group = "GitBranchBehind"
    elseif ahead > 0 then
        hl_group = "GitBranchAhead"
    end

    return string.format("%%#%s# %s %%*┃ ", hl_group, branch)
end

-- EXPOSE TO STATUSLINE
_G.mode_name = mode_name
_G.git_branch_status = git_branch_status

-- STATUSLINE HIGHLIGHTS
vim.cmd [[
    " Git status highlight groups
    highlight! link GitBranchUpToDate DiffAdded
    highlight! link GitBranchBehind ErrorMsg
    highlight! link GitBranchAhead WarningMsg

    " Mode highlight groups (link to existing theme highlights or define custom)
    highlight! link StatusModeNormal Keyword
    highlight! link StatusModeInsert String
    highlight! link StatusModeVisual Identifier
    highlight! link StatusModeCommand Type
    highlight! link StatusModeReplace Constant
    highlight! link StatusModeTerminal Special
    highlight! link StatusModeUnknown Comment

    " Other statusline components
    highlight! link StatusFileName Directory
    highlight! link StatusPosition Special
]]

-- SET STATUSLINE
vim.opt.laststatus = 2

vim.opt.statusline = table.concat({
    "%{%v:lua.git_branch_status()%}", -- Git branch
    "%{%v:lua.mode_name()%}",         -- Mode
    "┃ ",
    "%#StatusFileName#%<%f%*",        -- File path with color
    " %=",
    "%#StatusPosition#%l,%c%*",       -- Line, column
    " ┃ ",
    "%#StatusPosition#%P%*",          -- Position in file
})
