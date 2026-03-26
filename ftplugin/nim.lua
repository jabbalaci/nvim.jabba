vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'nim',
  callback = function()
    vim.opt_local.foldmethod = 'manual'
    vim.opt_local.foldenable = false
    vim.cmd 'syntax off'
  end,
})
