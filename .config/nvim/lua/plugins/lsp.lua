return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls" },
                automatic_installation = true,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            -- Neovim 0.11+ native LSP configuration
            vim.lsp.config.clangd = {
                cmd = { "clangd", "--background-index", "--clang-tidy" },
                filetypes = { "c", "cpp", "objc", "objcpp" },
            }

            vim.lsp.config.lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            }

            -- Enable the servers
            vim.lsp.enable("clangd")
            vim.lsp.enable("lua_ls")

            -- Keybindings on LSP attach (matching your existing ALE bindings)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf, noremap = true, silent = true }

                    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>lx", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                    vim.wo.signcolumn = "yes"
                end,
            })
        end,
    },
}
