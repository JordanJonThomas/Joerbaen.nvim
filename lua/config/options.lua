-- vim options
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.have_nerd_font = true 
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a' -- I like mouse mode sometimes :)
vim.opt.cursorline = true -- find cursor easier
vim.opt.showmode = false -- this is included in status line
vim.opt.laststatus = 3 -- statusbar at bottome
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true -- because 'ex' should autocomplete to 'Explore' imo
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- we LOVE the gutter
vim.opt.fillchars = { eob = ' ' }
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300 -- longer timeout for which-key is nice
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { trail = '·', nbsp = '␣' } -- i leave too many spaces at the end of my lines
vim.opt.icm = 'nosplit' -- substitution preview in new window
vim.opt.scrolloff = 10
vim.opt.tabstop = 4 -- any other number is blasphemous
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.g.loaded_netrwPlugin = 1 -- disable netrw because it SUCKS
vim.g.loaded_retrw = 1
vim.opt.cmdheight = 0 -- hide command window when not entering commands

local map = vim.keymap.set

-- more visual window seperators 
vim.api.nvim_create_autocmd('ColorScheme', { -- this overrides the default colorscheme
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#202024', bg = 'NONE', bold = true })
  end,
})
vim.opt.fillchars = 'vert:┃,horiz:━,horizup:┻,horizdown:┳,vertleft:┫,vertright:┣,verthoriz:╋'

-- check OS and set default shell
local os = vim.loop.os_uname().sysname;
if os == 'Windows_NT' then
  vim.o.shell = "pwsh.exe"
  vim.o.shellxquote = ''
  vim.o.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command '
  vim.o.shellquote = ''
  vim.o.shellpipe = '| Out-File -Encoding UTF8 %s'
  vim.o.shellredir = '| Out-File -Encoding UTF8 %s'
end -- TODO: set linux shell

-- clipboard assignment for register '+'
vim.schedule(function() -- kickstart.nvim says this makes this load faster :shrug:
  vim.opt.clipboard = 'unnamedplus'
end)

-- not a fan of default vim folds, adding some custom functionality here
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
map('n', '<leader>ft', 'za', { desc = '[F]old [T]oggle' })
map('n', '<leader>frt', 'zA', { desc = '[F]old [R]ecursive [T]oggle' })
map('n', '<leader>fo', 'zo', { desc = '[F]old [O]pen' })
map('n', '<leader>fro', 'zO', { desc = '[F]old [R]ecursive [O]pen' })
map('n', '<leader>fc', 'zc', { desc = '[F]old [C]lose' })
map('n', '<leader>frc', 'zC', { desc = '[F]old [R]ecursive [C]lose' })
map('n', '<leader>fO', 'zR', { desc = '[F]old [O]pen (all)' })
map('n', '<leader>fC', 'zM', { desc = '[F]old [C]lose (all)' })
