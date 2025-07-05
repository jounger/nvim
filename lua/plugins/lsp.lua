return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        opts = {
            servers = {
                lua_ls = {},
                gopls = {},
                pyright = {
                    on_attach = function(client, bufnr)
                        client.server_capabilities.documentFormattingProvider = false
                    end,
                },
            },
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            for server, config in pairs(opts.servers) do
                config.capabilites = require("blink.cmp").get_lsp_capabilities(config.capabilites)
                lspconfig[server].setup(config)
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    -- Format the current buffer on save
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = args.buf,
                        callback = function()
                            -- use autopep8 to format
                            if vim.bo[args.buf].filetype == "python" then return end
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                        end,
                    })
                end,
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local helpers = require("null-ls.helpers")
            local autopep8 = {
                name = "autopep8",
                method = null_ls.methods.FORMATTING,
                filetypes = { "python" },
                generator = helpers.formatter_factory({
                    command = "autopep8",
                    args = { "-" },
                    to_stdin = true,
                }),
            }

            null_ls.setup({
                sources = {
                    autopep8
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
            })
        end
    }
}
