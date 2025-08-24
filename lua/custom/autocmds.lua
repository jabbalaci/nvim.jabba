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

-- start the terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.cmd 'startinsert'
  end,
})

-- {{ highlight the '!' (not) sign
-- Create the highlight group once
vim.api.nvim_set_hl(0, 'NegationBang', { bg = '#ffff00', ctermbg = 3 })
-- yellow: "#ffff00"
-- a bit darker: "#ffe300"

-- Define the autocommand
local negation_group = vim.api.nvim_create_augroup('NegationBang', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  group = negation_group,
  pattern = { '*.d', '*.c', '*.java', '*.h', '*.cpp', '*.cc', '*.hpp' }, -- edit to taste
  callback = function(args)
    -- matchadd() returns an id; store it in buffer-local var so we can clear it
    if vim.b[args.buf].negation_bang_id then
      vim.fn.matchdelete(vim.b[args.buf].negation_bang_id)
    end
    -- vim.b[args.buf].negation_bang_id = vim.fn.matchadd('NegationBang', [[\%(\s\|(\)\zs!]], -1)  -- previous, was OK
    vim.b[args.buf].negation_bang_id = vim.fn.matchadd('NegationBang', [[\%(\s\|(\)\zs!\ze=\@!]], -1)
  end,
})
-- }} highlight the '!' (not) sign
