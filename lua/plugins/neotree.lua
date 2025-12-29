return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        -- Open side tree
        { '\\', function ()
            --print(vim.bo.filetype)
            if vim.bo.filetype == 'neo-tree' then
                vim.cmd("Neotree close")
            else
                vim.cmd("Neotree reveal position=left")
            end
        end, desc = 'NeoTree reveal', silent = true },

        -- Explore command
        { '<leader>ex', ':Neotree current<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = function(_, opts)
        -- remove netrw and replace
        opts.filesystem = opts.filesystem or {}
        opts.filesystem.hijack_netrw_behavior =
        opts.filesystem.hijack_netrw_behavior or "open_current"

        opts.filesystem.window = opts.filesystem.window or {}
        opts.filesystem.window.position =
        opts.filesystem.window.position or "current"

        opts.filesystem.window.mappings =
        vim.tbl_extend("force", opts.filesystem.window.mappings or {}, {
            ["\\"] = "close_window",
        })

        -- Integrate snack rename
        local events = require("neo-tree.events")

        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
            {
                event = events.FILE_MOVED,
                handler = function(data)
                    Snacks.rename.on_rename_file(data.source, data.destination)
                end,
            },
            {
                event = events.FILE_RENAMED,
                handler = function(data)
                    Snacks.rename.on_rename_file(data.source, data.destination)
                end,
            },
        })
    end,
}
