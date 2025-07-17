function ColorMyPencils(color)
    color = color or "catppuccin"
    vim.cmd.colorscheme(color)

    -- Setup
    --require("catppuccin").setup({ flavour = "mocha" }) -- or "macchiato"
    --vim.cmd.colorscheme "catppuccin"
    vim.api.nvim_set_hl(0, "@underline", { link = "Underlined" })
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
