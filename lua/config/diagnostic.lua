local show_text = false

local toggle_virtual_text = function()
    show_text = not show_text
    vim.diagnostic.config({ virtual_text = show_text })
end

vim.keymap.set("n", "<leader>le", toggle_virtual_text)
