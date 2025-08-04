local M = {}

function M.surround()
  local open = vim.fn.input 'Surround with: '
  if not open then
    return
  end
  if open == '' then
    vim.notify ''
    return
  end
  local close = ({ ['{'] = '}', ['('] = ')', ['['] = ']', ['<'] = '>' })[open]
  if not close then
    close = open
  end
  local cmd = 'c' .. open .. [[<C-R>"]] .. close .. '<Esc>'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), 'n', true)
end

-- q, like "quote"
vim.keymap.set('v', 'q', M.surround, { desc = 'Surround with' })

return M
