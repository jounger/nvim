return {
    {
        "tpope/vim-fugitive",
    },
    {
        "echasnovski/mini.surround",
        config = function()
            require('mini.surround').setup()
        end
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
            vim.g.undotree_WindowLayout = 3
            vim.g.undotree_SplitWidth = 50
            vim.g.undotree_DiffAutoOpen = 1
        end
    },
}
