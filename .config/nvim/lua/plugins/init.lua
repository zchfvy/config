return {
    {
        'dense-analysis/ale',
        config = function()
            -- Configuration goes here.
            local g = vim.g

            g.ale_ruby_rubocop_auto_correct_all = 1

            g.ale_linters = {
                ruby = { 'rubocop', 'ruby' },
                lua = { 'lua_language_server' },
                c = { 'clangd' },
                cpp = { 'clangd' }
            }
        end
    },
    -- 'vim-airline/vim-airline',

    'tpope/vim-abolish',
    'tpope/vim-dispatch',
    'tpope/vim-fugitive',
    'tpope/vim-obsession',
    'tpope/vim-repeat',
    'tpope/vim-speeddating',
    'tpope/vim-surround',
    'junegunn/vim-easy-align',

    'scrooloose/nerdtree',
    'Xuyuanp/nerdtree-git-plugin',
    'preservim/tagbar',
    'mbbill/undotree',

    'ervandew/supertab',
    { 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' } },
    'ctrlpvim/CtrlP.vim',
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            highlight = {
                -- Don't "hide" colon
                keyword = "bg",
                pattern = [[.{-}<(\s?(KEYWORDS):)]],
            }
        }
    },
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffviewOpen", "DiffviewDileHistory" },
        opts = {
        }
    },
    {
        "greggh/claude-code.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("claude-code").setup({
                keymaps = {
                    toggle = {
                        normal = "<C-\\>",
                        terminal = "<C-\\>"
                    }
                }
            })
        end
    }
}
