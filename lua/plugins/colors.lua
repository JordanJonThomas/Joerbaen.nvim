return {
    -- better syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        branch = "main",
        config = function(_, opts)
            --local ts = require('nvim-treesitter')

            --local ensure_installed = { 'nu', 'c', 'rust', 'lua', 'luadoc', 'markdown'}
            --local alread_installed = ts.get_installed()

            --local to_install = vim
            --    :iter(ensure_installed)
            --    :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
            --    :totable()

            --if #to_install > 0 then
            --    ts.install(to_install)
            --end

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
