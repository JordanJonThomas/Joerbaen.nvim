return {
    'jvgrootveld/telescope-zoxide',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope.nvim'
    },
    config = function()
        local telescope = require('telescope')
        telescope.load_extension('zoxide')

        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        -- change cwd and jump with neotree
        local function zoxide_go()
            telescope.extensions.zoxide.list({
                attach_mappings = function(prompt_bufnr)
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        if selection then
                            vim.cmd("Neotree filesystem reveal dir=" .. selection.value)
                        end
                    end)
                    return true
                end,
            })
        end

        -- export for keys
        _G.zoxide_go = zoxide_go
    end,
    keys = {
        -- change cwd, open zoxide search using telescope, uses zoxide db, 
        { "<leader>z", function() _G.zoxide_go() end, desc = "Zoxide jump" },

        -- change cwd to home directory in neotree
        { "<leader>cd", function() 
            vim.cmd("cd ~") 
            vim.cmd("Neotree filesystem reveal dir=" .. vim.fn.expand("~"))
        end, desc = "Zoxide home" },

    }
}
