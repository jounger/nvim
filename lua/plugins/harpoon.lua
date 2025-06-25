vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')

local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end
    local themes = require('telescope.themes')
    local opts = themes.get_ivy({
        promt_title = "Working List"
    })

    local conf = require('telescope.config').values
    require("telescope.pickers").new(opts, {
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer(opts),
        sorter = conf.generic_sorter(opts),
    }):find()
end

return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local harpoon = require('harpoon')
            vim.keymap.set("n", "<leader>ha", function()
                local is_existed = false
                local current_file_path = vim.api.nvim_buf_get_name(0)
                local current_file_relative_path = vim.fn.expand("%:.")
                for index = 1, harpoon:list():length() do
                    local harpoon_file_path = harpoon:list():get(index).value
                    -- delete from list if existed
                    if harpoon_file_path == current_file_relative_path or harpoon_file_path == current_file_path then
                        harpoon:list():remove_at(index)
                        is_existed = true
                        break
                    end
                end

                -- add to list if not existed
                if not is_existed then
                    harpoon:list():add()
                end
                vim.cmd(":do User")
            end)
            vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<leader>hp", function() toggle_telescope(harpoon:list()) end)

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
        end
    }
}
