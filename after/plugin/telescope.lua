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

-- Code Actions
require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    }
}

-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
