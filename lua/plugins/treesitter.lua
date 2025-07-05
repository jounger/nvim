return {
    {
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
                sync_install = false,
                ignore_install = {},
                ensure_installed = {
                    "lua",
                    "tsx",
                    "typescript",
                    "javascript",
                    "go",
                    "python",
                    "php",
                    "html",
                    "htmldjango",
                    "twig",
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup {
                mode = 'topline',
                enable = true,
                multiwindow = true,
                max_lines = 0,
                line_numbers = true,
            }
        end
    },
}
