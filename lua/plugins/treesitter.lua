return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            autotage = { enable = true },
            auto_install = false,
            ensure_installed = {
                "vim",
                "lua",
                "tsx",
                "typescript",
                "javascript",
                "go",
                "gomod",
                "python",
            },
        })
    end
}
