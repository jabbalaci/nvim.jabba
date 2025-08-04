local M = {}

function M.echo_test()
  vim.api.nvim_echo({ { 'text coming from my_plugin', 'Normal' } }, true, {})
end

return M

--- how to map it:
---
-- vim.keymap.set('n', '<A-l>', function()
--   require('custom.my_plugin').echo_test()
-- end, { desc = 'Echo test' })
