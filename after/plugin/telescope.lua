local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Show diagnostics for the whole workspace
vim.keymap.set('n', '<leader>dw', function()
    builtin.diagnostics({
        bufnr = nil,                -- Workspace diagnostics
        path_display = { "smart" }, -- Clean relative path display
    })
end, { desc = "Workspace Diagnostics" })

-- Show diagnostics for the current buffer
vim.keymap.set('n', '<leader>db', function()
    builtin.diagnostics({ bufnr = 0 })
end, { desc = "Buffer Diagnostics" })

-- Telescope setup
require("telescope").setup {
    defaults = {
        file_ignore_patterns = {
            "%.env",        -- ignore .env files
            "%.venv",       -- ignore .venv directories
            "node_modules", -- ignore node_modules
            "%.git",        -- ignore .git
            "dist",         -- ignore dist folder
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--glob', '!.venv/**',        -- ignore .venv folder
            '--glob', '!.env/**',         -- ignore .env folder
            '--glob', '!node_modules/**', -- ignore node_modules
            '--glob', '!.git/**',         -- ignore .git
            '--glob', '!dist/**',         -- ignore dist folder
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    }
}

-- Load extensions
require("telescope").load_extension("ui-select")
