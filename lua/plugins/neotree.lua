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
  opts = {
    filesystem = {
      hijack_netrw_behavior = "open_current",
      window = {
        position = "current",
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
