local function airline_config()
    -- vim.g["airline#extensions#tabline#enabled"] = true
    -- vim.g["airline#extensions#tabline#show_buffers"] = true  -- Show buffers
    -- vim.g["airline#extensions#tabline#tab_nr_type"] = 1  -- Show tab numbers
    -- vim.g["airline#extensions#tabline#buffer_min_count"] = 2  -- Hide tabline when there is only one buffer

    --vim.g.airline_theme = 'base16'
    vim.g.airline_powerline_fonts = true
end

return {
    {
        "vim-airline/vim-airline",
        init = airline_config,
        dependencies = {
            "vim-airline/vim-airline-themes",
        }
    },
}
