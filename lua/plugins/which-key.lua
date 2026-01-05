return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
        -- Whichkey spec
        spec = {
            {'<leader>s', group = '[S]earch' },
            {'<leader>g', group = '[G]it' },
            {'<leader>c', group = '[C]ode' },
            {'<leader>o', group = '[O]pen' },
            {'<leader>p', group = '[P]ersist' },
            {'<leader>t', group = '[T]oggle' },
            {'<leader>d', group = '[D]ocument' },
            {'<leader>w', group = '[W]orkspace' },
            {'<leader>f', group = '[F]old' },
            {'<leader>fr', group = '[F]old [R]ecursive' },
            {'<leader>e', hidden = true },
        },
        -- exclude mappings without description
        filter = function(mapping)
            return mapping.desc and mapping.desc ~= ""
        end,
   },
}
