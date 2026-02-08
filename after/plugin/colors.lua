function ColorMyPencils(color)
    color = color or "catppuccin"

    require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
            bufferline = true,
            nvimtree = true,
            treesitter = true,
            telescope = true,
        }
    })

    vim.cmd.colorscheme(color)

    require("bufferline").setup({
        options = {
            mode = "buffers",
            separator_style = "thin",
            always_show_bufferline = true,
            show_buffer_close_icons = false,
            show_close_icon = false,
            color_icons = true,

            indicator = {
                style = 'none',
            },

            -- Formatting: Icons + Name + Extension (Default behavior)
            show_buffer_icons = true,
            show_tab_indicators = false,
            persist_buffer_sort = true,

            -- Disable italics globally for the tabline
            italic = false,
        },
        highlights = {
            buffer_selected = {
                italic = false,
                bold = true,
            },
            modified_selected = {
                italic = false,
            },
        }
    })

    vim.api.nvim_set_hl(0, "@underline", { link = "Underlined" })
end

ColorMyPencils()

-- Tab navigation (Shift + h/l)
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Tab" })
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "gt", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Tab" })
vim.keymap.set("n", "gT", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Tab" })

-- Reorder tabs (Control + h/l)
vim.keymap.set("n", "<C-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move Tab Left" })
vim.keymap.set("n", "<C-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Tab Right" })

-- Close tab
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<cmd>q", "<cmd>bdelete<cr>", { desc = "Close Tab" })
