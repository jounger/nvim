local function tabs(list)
    local contents = {}
    local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
    for index = 1, list:length() do
        local harpoon_file_path = list:get(index).value
        local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ':t')
        if current_file_path == harpoon_file_path then
            contents[index] = string.format("%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ", index, file_name)
        else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, file_name)
        end
    end

    return table.concat(contents)
end

vim.opt.showtabline = 2
vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "User" }, {
    callback = function()
        local harpoon = require('harpoon')
        local list = harpoon:list()
        vim.o.tabline = tabs(list)

        -- set keymap for each tab
        for index = 1, list:length() do
            vim.keymap.set("n", string.format("<a-%s>", index), function() list:select(index) end)
        end
    end
})
