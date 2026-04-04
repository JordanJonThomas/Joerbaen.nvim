return {
    {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        opts = { hint = 'floating-letter'}
    },

    {
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

                -- store directory in zoxide db and change cwd
                ["z"] = {
                    function(state)
                        local node = state.tree:get_node()
                        if node and node.type == "directory" then
                            local path = node:get_id()
                            -- Update zoxide internal list
                            vim.system({"zoxide", "add", path}, {}, function() end)
                            -- Change nvim cwd
                            vim.cmd("cd " .. path)
                            -- Open neotree at the new directory
                            vim.cmd("Neotree filesystem reveal dir=" .. path)
                            print("Zoxide updated and changed cwd to: " .. path)
                        else
                            print("Zoxide navigation only works for directories")
                        end
                    end,
                    desc = "Zoxide add and navigate to directory"
                },

                -- store directory in zoxide db
                ["Z"] = {
                    function(state)
                        local node = state.tree:get_node()
                        if node and node.type == "directory" then
                            local path = node:get_id()
                            -- Update zoxide internal list
                            vim.system({"zoxide", "add", path}, {}, function() end)
                        else
                            print("Zoxide only works on directories")
                        end
                    end,
                    desc = "Zoxide add"
                },
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
}
