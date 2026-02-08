local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = 'Telescope Live Grep' })
vim.keymap.set("n", "<leader>pv", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

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
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                preview_width = 0.56, -- Adjust this to give more/less room to the file content
                results_width = 0.8,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
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
            require("telescope.themes").get_dropdown {}
        },
        ["file_browser"] = {
            theme = "ivy",       -- Or "center", but "ivy" looks great for explorers
            hijack_netrw = true, -- This officially replaces Netrw
            initial_mode = "normal",
            layout_config = {
                prompt_position = "bottom",
            },
        }
    }
}

-- Load extensions
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
