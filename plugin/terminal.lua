local buffer = -1
local window = -1

local toggle_terminal = function()
    if vim.api.nvim_win_is_valid(window) then
        return vim.api.nvim_win_hide(window)
    end


    buffer = vim.api.nvim_buf_is_valid(buffer) and buffer or vim.api.nvim_create_buf(false, true)
    window = vim.api.nvim_open_win(buffer, true, {
        win = 0,
        height = 10,
        split = "below",
        style = "minimal",
    })
    if vim.bo[buffer].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end

-- escape terminal mode by double esc button
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<c-\\>", toggle_terminal)
