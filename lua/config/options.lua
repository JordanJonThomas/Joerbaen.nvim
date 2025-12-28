-- Default vim options
vim.g.mapleader = ' ' -- MUST be assigned before lazy loaded
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
vim.opt.timeoutlen = 300 -- qol for which-key
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { trail = '·', nbsp = '␣' } -- trailing dot is nice        
vim.opt.icm = 'nosplit' -- substitution preview in new window
vim.opt.scrolloff = 10
vim.opt.tabstop = 4 -- fix tabs
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.g.loaded_netrwPlugin = 1 -- disable netrw because it SUCKS
vim.g.loaded_retrw = 1

-- check OS and set default shell
local os = vim.loop.os_uname().sysname;
if os == 'Windows_NT' then
  vim.o.shell = "powershell.exe"
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

