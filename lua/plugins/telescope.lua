return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VimEnter',
    opts = { defaults = { 
        file_ignore_patterns = {".git/"},
        winblend = 0
    }},
    config = function()
        local telescope = require('telescope') -- Default telescope pickers
        local builtin = require('telescope.builtin') -- Default telescope pickers

        local map = function(pattern, exec, other) -- mapper no mode :shocked:
            other = other or {} -- no args given
            vim.keymap.set("n", pattern, exec, other)
        end

        -- file search
        map('<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        map('<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
        map('<leader>sg', builtin.live_grep, { desc = '[S]earch [G]rep' })
        map('<leader>sc', function ()
            builtin.find_files({
                cwd = vim.fn.stdpath('config'),
                prompt_title = 'Neovim Config',
            })
        end , { desc = '[S]earch [C]onfig' })

    end,
}


