return {
    -- better syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        lazy = false,
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'c', 'rust', 'lua', 'luadoc', 'markdown'},
            auto_install = true,
        }
    },

    -- adwaita is nice
    {
        'Mofiqul/adwaita.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.adwaita_transparent = true
            vim.cmd('colorscheme adwaita')
        end
    },
}
