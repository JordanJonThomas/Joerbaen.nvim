-- Disable in specific filetypes or buftypes
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  callback = function()
    if vim.bo.filetype == "neo-tree"
       or vim.bo.buftype == "nofile"
       or vim.bo.buftype == "terminal"
    then
      vim.opt_local.colorcolumn = ""
    end
  end,
})
