require('lualine').setup({
    options = {
        theme = 'auto', -- Automatically fits your colorscheme
        component_separators = { left = '┃', right = '┃' },
        section_separators = { left = '', right = '' }, -- Slight slant for a modern feel
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            { 'mode', fmt = function(str) return ' ' .. str end }
        },
        lualine_b = {
            { 'branch', icon = '' },
            {
                'diff',
                symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            },
        },
        lualine_c = {
            { 'filename', path = 1, symbols = { modified = ' ●', readonly = ' 󰖭' } },
            -- EXTRA: Macro Recording indicator (super helpful)
            {
                function()
                    local reg = vim.fn.reg_recording()
                    if reg == "" then return "" end
                    return "󰑋  RECORDING @" .. reg
                end,
                color = { fg = "#ff0000", gui = "bold" },
            },
        },
        lualine_x = {
            -- EXTRA: LSP Status (shows which server is active)
            {
                function()
                    local msg = 'No LSP'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then return msg end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                icon = ' ',
                color = { fg = '#ffffff', gui = 'bold' },
            },
            { 'diagnostics', sources = { 'nvim_diagnostic' } },
            'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})
