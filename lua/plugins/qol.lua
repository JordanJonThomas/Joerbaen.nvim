-- Generally useful plugins with little configure required
return {
    -- provides progress info in bottom corner (lsp primarily)
    {
        'j-hui/fidget.nvim',
        opts = {
            notification = {
                window = { winblend = 0 },
            }
        }
    },

    -- highlight TODO comments 
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts =  function(_, opts)
            local mine = {
                keywords = {
                    -- UNWRAP: i added unwrap for rust documentation because i have a problem 🦀
                    UNWRAP = { icon = '', color = 'warning' }
                },
            }

            return vim.tbl_deep_extend('force', opts, mine)
        end,
    },

    -- mini nvim 
    {
        'nvim-mini/mini.nvim',
        version = false,
        config = function()
            -- not actaully ai, improvements to vim a and i motions
            require('mini.ai').setup { n_lines = 500 }

            -- there are some other cool little plugins in this package so come back here
        end
    },

    -- autopairs
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {
            check_ts = true
        },
        config = function(_, opts)
            local npairs = require('nvim-autopairs')
            local Rule = require('nvim-autopairs.rule')
            local cond = require('nvim-autopairs.conds')
            npairs.setup(opts)

            -- eruby pairs for rails
            npairs.add_rules({
                Rule('<%', ' %>', {'eruby'})
                    :use_regex(false)
                    :set_end_pair_length(3)
            })

            -- npairs.add_rules({
            --     Rule('<', '>')
            --         :use_regex(false)
            --         :set_end_pair_length(1)
            -- })
        end,
    },

    -- dead column 
    {
        'Bekaboo/deadcolumn.nvim',
        init = function()
            vim.opt.colorcolumn = '100' -- Dead column position
        end,
        opts = {
            scope = 'line',
            modes = function(mode)
                -- Don't show in read-only buffers
                if not vim.bo.ma or vim.bo.ro then
                    return 0
                end

                -- Always display in insert
                if mode == 'i' then
                    return true
                else
                    -- Any other mode, Get length of current line
                    local ok, line_width = pcall(function()
                        return vim.fn.strdisplaywidth(vim.api.nvim_get_current_line())
                    end)

                    -- Render line based on current line width and percentage below
                    -- 1 means render only if length >= colorcolumn_len
                    -- 0 means no render at all.
                    local percent_of_column = 1
                    ok = false
                    if ok and line_width >= tonumber((vim.wo.colorcolumn:match('%d+') or 0) * percent_of_column) then
                        return true
                    end
                end
            end,
        }
    },

    -- nested terminal
    {
        'akinsho/toggleterm.nvim',
        dependencies = 'folke/which-key.nvim',
        version = "*",
        opts = {
            size = function(term)
                -- vertical size
                if term.direction == 'vertical' then
                    return vim.o.columns * 0.4
                end

                -- default size
                return 20
            end
        },
        keys = function()
            local Terminal = require('toggleterm.terminal').Terminal
            local wk = require('which-key')

            -- terminal applications to be used
            local lazygit = Terminal:new({
                cmd = 'lazygit',
                hidden = true,
                direction = 'float',
            })

            wk.add({"<leader>ot", group = '[O]pen [T]erminal'})
            local hz = Terminal:new({ hidden = true, direction = 'horizontal' })
            local vt = Terminal:new({ hidden = true, direction = 'vertical'})

            return {
                {'<leader>ol', function() lazygit:toggle() end, desc = '[O]pen [L]azygit'},
                {'<leader>otv', function() vt:toggle() end, desc = '[O]pen [T]erminal [V]ertical'},
                {'<leader>oth', function() hz:toggle() end, desc = '[O]pen [T]erminal [H]orizontal'}
            }
        end

    },

    -- sessions
    {
        'folke/persistence.nvim',
        event = 'VimEnter',
        opts = {},
        keys = {
            vim.keymap.set('n', '<leader>ps', function() require('persistence').select() end, {desc='[P]ersist [S]elect'}),
            vim.keymap.set('n', '<leader>pl', function() require('persistence').load({ last = true }) end, {desc = '[P]ersist [L]ast session'}),
        },
    },

    -- markdown
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
}
