    -- snacks :)
return {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- Good as is pluginss
            animate = { enabled = true },
            bigfile = { enabled = true },
            gh = { enabled = true },
            indent = { enabled = false },
            input = { enabled = true },
            image = { enabled = true },
            lazygit = { enabled = false },
            notify = { enabled = false },
            quickfile = { enabled = true },
            scope = { enabled = true },
            statuscolumn = { enabled = false },
            scroll = { enabled = true },
            terminal = { enabled = false },
            words = { enabled = true },
            picker = { enabled = true, ui_select = true },
            rename = { enabled = true },

            -- Custom dashboard
            dashboard = {
                enabled = true,
                preset = {
                    pick = nil,
                    keys = {
                        { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.dashboard.pick("files")' },
                        { icon = ' ', key = 'e', desc = 'Explore Files', action = ':Neotree' },
                        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
                        { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.dashboard.pick("live_grep")' },
                        { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick("oldfiles")' },
                        { icon = ' ', key = 'c', desc = 'Config', action = ':lua Snacks.dashboard.pick("files", {cwd = vim.fn.stdpath("config")})' },
                        { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
                        { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                        { icon = ' ', key = 'l', desc = 'LeetCode', action = '<cmd>Leet<CR>' },
                        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
                    },
                    header = [[
      ███                              █████                                                              ███                 
     ░░░                              ░░███                                                              ░░░                  
     █████  ██████   ██████  ████████  ░███████   ██████    ██████  ████████      ████████   █████ █████ ████  █████████████  
    ░░███  ███░░███ ███░░███░░███░░███ ░███░░███ ░░░░░███  ███░░███░░███░░███    ░░███░░███ ░░███ ░░███ ░░███ ░░███░░███░░███ 
     ░███ ░███ ░███░███████  ░███ ░░░  ░███ ░███  ███████ ░███████  ░███ ░███     ░███ ░███  ░███  ░███  ░███  ░███ ░███ ░███ 
     ░███ ░███ ░███░███░░░   ░███      ░███ ░███ ███░░███ ░███░░░   ░███ ░███     ░███ ░███  ░░███ ███   ░███  ░███ ░███ ░███ 
     ░███ ░░██████ ░░██████  █████     ████████ ░░████████░░██████  ████ █████ ██ ████ █████  ░░█████    █████ █████░███ █████
     ░███  ░░░░░░   ░░░░░░  ░░░░░     ░░░░░░░░   ░░░░░░░░  ░░░░░░  ░░░░ ░░░░░ ░░ ░░░░ ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ 
 ███ ░███                                                                                                                     
░░██████                                                                                                                      
 ░░░░░░                                                                                                                       ]],
            },
        }
    },
    keys = {
        { '<leader>gi', function() Snacks.picker.gh_issue() end, desc = '[G]ithub [I]ssues' },
        -- { '<leader>ol', function() Snacks.lazygit.open() end, desc = '[O]pen [L]azygit' },
        { '<leader>od', function() Snacks.dashboard() end, desc = '[O]pen [D]ashboard' },
    }
}
