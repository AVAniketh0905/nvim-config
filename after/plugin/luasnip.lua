local luasnip = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    return luasnip.expand_or_jumpable() and luasnip.expand_or_jump()
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    return luasnip.jumpable(-1) and luasnip.jump(-1)
end, { silent = true })

vim.keymap.set("i", "<C-l>", function()
    require("luasnip.extras.select_choice")()
end, { silent = true })
