-- pretty much everything LSP related is covered here
return {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    {
        'folke/lazydev.nvim',
        ft = 'lua',
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {"mason-org/mason.nvim", config = true},
        },
        config = function ()
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

        end
    },

    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = { 'neovim/nvim-lspconfig' },
        opts = function(_, opts)
            local lspconfig = require("lspconfig")

            -- ensure required servers areinstalled by Mason
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                "ruby_lsp",
            })

            opts.handlers = {
                -- Default for all installed servers
                function(server_name)
                    lspconfig[server_name].setup({})
                end,

                ruby_lsp = function()
                    --lspconfig.ruby_lsp
                end,

                lua_ls = function ()
                    local lsp_opts = {
                        settings = {
                            Lua = {
                                runtime = { version = 'LuaJIT'},
                                workspace = {
                                    library = require('lazydev').library(),
                                    checkthirdParty = false,
                                },
                                diagnostics = { globals = { 'vim' } },
                                telemetry = { enable = false },
                            },
                        },
                    }
                    lspconfig.lua_ls.setup(lsp_opts)
                end,
            }

            return opts
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',   -- LSP source
            'hrsh7th/cmp-buffer',     -- Buffer completions
            'hrsh7th/cmp-path',       -- File path completions
            'hrsh7th/cmp-cmdline',    -- Command-line completions
            'L3MON4D3/LuaSnip',       -- Snippet engine
            'saadparwaiz1/cmp_luasnip' -- Snippet completions
        },

        config = function()
            -- See `:help cmp`
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert {
                    -- Select the [n]ext item
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ['<C-p>'] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<C-y>'] = cmp.mapping.confirm { select = true },

                    -- If you prefer more traditional completion keymaps,
                    -- you can uncomment the following lines
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ['<C-Space>'] = cmp.mapping.complete {},

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                },
                sources = {
                    {
                        name = 'lazydev',
                        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                        group_index = 0,
                    },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
            }
        end,
    }
}
