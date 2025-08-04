-- custom commands
-- Create the :This command (must start with a capital letter)
vim.api.nvim_create_user_command('This', function()
  -- vim.cmd 'BufferLineCloseOthers'  -- v1
  require('bufferline').close_others() -- v2
  vim.cmd 'only'
end, { desc = 'Close others (tabs, buffers)' })

-- Show trailing newlines as ¬
vim.opt.list = false
vim.opt.listchars = { eol = '¬' }

vim.api.nvim_create_user_command('ShowNewLine', function()
  -- vim.opt.list = not vim.opt.list._value
  local current = vim.api.nvim_get_option_value('list', {})
  vim.api.nvim_set_option_value('list', not current, {})
end, { desc = 'Show/hide newline characters' })
