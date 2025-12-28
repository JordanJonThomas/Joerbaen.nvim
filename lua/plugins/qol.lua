-- Generally useful plugins with little configure required
return {

    -- Highlight TODO comments
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

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
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
                Rule('<%', ' %>', {"eruby"})
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

    -- Dead column 
    {
        'Bekaboo/deadcolumn.nvim',
        init = function()
            vim.opt.colorcolumn = "100" -- Dead column position
        end,
        opts = {
            scope = 'line',
            modes = function(mode)
                -- Don't show in read-only buffers
                if not vim.bo.ma or vim.bo.ro then
                    return 0
                end

                -- Always display in insert
                if mode == "i" then
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
                    if ok and line_width >= tonumber((vim.wo.colorcolumn:match("%d+") or 0) * percent_of_column) then
                        return true
                    end
                end
            end,
        }
    },

    -- nested terminal
    {
        's1n7ax/nvim-terminal',
        config = function()
            vim.o.hidden = true

            vim.keymap.set("n", "<leader>ot",  "<C-w>v:terminal<CR>", { desc = '[O]pen [T]erminal' })  
            vim.keymap.set("n", "<leader>oth", "<C-w>s:terminal<CR>", { desc = '[O]pen [T]erminal [H]orizontally' }) 
        end,
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            animate = { enabled = true },
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            gh = { enabled = true },
            indent = { enabled = false },
            input = { enabled = true },
            image = { enabled = true },
            lazygit = { enabled = true },
            notify = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            statuscolumn = { enabled = false },
            scroll = { enabled = true },
            terminal = { enabled = false },
            words = { enabled = true },
        },
        keys = {
            { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "[G]ithub [I]ssues" },
        }
    },

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
