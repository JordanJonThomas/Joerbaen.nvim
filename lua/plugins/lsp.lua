return {
    { 'mason-org/mason.nvim', opts={} },

    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'saghen/blink.cmp' },
        config = function()
            local caps = require('blink.cmp').get_lsp_capabilities()
            vim.lsp.config('*', {
                capabilities = caps,
            })

            -- lsp servers to install automatically
            vim.lsp.enable({
                'rust_analyzer',
                'lua_ls',
                'ts_ls',
                'omnisharp'
            })

            -- map keys on lsp attach
            local builtin = require('telescope.builtin') -- telescopalicious
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
                    map("gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
                    map("<leader>gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
                    map("<leader>gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" }) -- like headers in c/c++
                    map("<leader>gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
                    map("<leader>gr", builtin.lsp_implementations, { desc = "[G]oto [I]mplementations" })
                    map("<leader>gt", vim.lsp.buf.type_definition, { desc = "[G]oto [T]ype definition" }) -- find type of symbol under cursor

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

            keymap = {
                preset = 'default',

                ['<C-a>'] = {'show', 'fallback'}, -- c-space cannot be called in powershell
                ['<C-Space>'] = {'show', 'fallback'},
                --['<Esc>'] = {'hide', 'fallback'},
                ['<CR>'] = {'fallback'},
            },

        },

        opts_extend = { 'sources.default' },
    },

}
