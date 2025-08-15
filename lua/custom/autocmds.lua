-- Optional: Disable the default Neovim intro completely
-- vim.opt.shortmess:append 'sI' -- Suppress startup messages

-- Go to last location when re-opening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_loc', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      -- Protected call to catch errors.
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-trim on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    -- Skip if disabled for current filetype
    local disabled_ft = { 'snippets' } -- Add filetypes to exclude
    if vim.tbl_contains(disabled_ft, vim.bo.filetype) then
      return
    end

    require('mini.trailspace').trim() -- Trim whitespace
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.cmd 'startinsert'
  end,
})
