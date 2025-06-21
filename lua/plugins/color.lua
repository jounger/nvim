return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "tokyonight"
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            theme = "tokyonight",
        }
    }
}
