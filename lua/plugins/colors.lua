return {
    -- better syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        lazy = false,
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'nu', 'c', 'rust', 'lua', 'luadoc', 'markdown'},
            highlight = { enable = true },
            auto_install = true,
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
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
