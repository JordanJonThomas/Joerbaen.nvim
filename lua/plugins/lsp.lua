return {
    {
        'mason-org/mason.nvim',
        opts={},
    },

    {
        'mason-org/mason-lspconfig.nvim', 
        dependencies = {'neovim/nvim-lspconfig' },
        config = function() 
            vim.lsp.enable({
                'rust_analyzer',
                'lua_ls',
                'ts_ls'
            })

            local builtin = require('telescope.builtin') -- telescopalicious

            -- map keys on lsp attach
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('jt-on-lsp-attach', {clear = true}),
                callback = function(event)
                    local map_mode = function(mode, pattern, exec, other) -- mapper with mode
                        other = other or {} -- no args given
                        local args = vim.tbl_deep_extend('force', {buffer = event.buf}, other);
                        vim.keymap.set(mode, pattern, exec, args)
                    end
                    local map = function(pattern, exec, other) -- mapper no mode :shocked:
                        map_mode("n", pattern, exec, other)
                    end

                    -- code search
                    map("gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
                    map("<leader>gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
                    map("<leader>gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" }) -- like headers in c/c++
                    map("<leader>gr", builtin.lsp_references , { desc = "[G]oto [R]eferences" })
                    map("<leader>gt", builtin.lsp_type_definitions , { desc = "[G]oto [T]ype definition" }) -- find type of symbol under cursor

                    -- symbol manipulation
                    map("<leader>ca", vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
                    map_mode({'n', 'x'}, "<leader>rn", vim.lsp.buf.rename, { desc = '[R]e[N]ame' })

                    -- color swapper :>
                    map("<leader>tc", builtin.colorscheme, { desc = "[T]oggle [C]olorscheme" })
                end,
            })
        end,
    },

    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'folke/lazydev.nvim',
        },
        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            completion = {
                documentation = {
                    auto_show = true,
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100, -- make lazydev completions top priority (see `:h blink.cmp`)
                    },
                },
            },
            signature = { enabled = true },
        },

        opts_extend = { 'sources.default' },
    },

}
