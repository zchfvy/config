local function treesitter_config()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python", "rust", "go", "html", "css", "json", "markdown", "glsl" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = false,  -- Temporarily disabled due to parser issues
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
    })
end

return {
    {
        "nvim-treesitter/nvim-treesitter", 
        branch = 'master', 
        lazy = false,
        build = ":TSUpdate",
        config = treesitter_config
    },
}