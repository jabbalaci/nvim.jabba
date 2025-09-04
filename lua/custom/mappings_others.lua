-- mappings for anything else

-- Alt-Space (thumb-friendly): switch between Normal and Insert mode
vim.keymap.set({ 'i', 'v' }, '<A-Space>', '<Esc>', { noremap = true })
vim.keymap.set('n', '<A-Space>', 'i', { noremap = true })

-- In XFCE (Manjaro Linux) the Alt+Space combination is hard-wired to
-- "Activate the window menu" (the small drop-down that appears at the
-- top-left of every window's title bar)
-- Disable it:
-- 1) Settings → Window Manager → Keyboard
-- 2) clear it

-- better word jumps
vim.keymap.set('n', 'w', 'W', { desc = 'Better next word' })
vim.keymap.set('n', 'W', 'w', { noremap = true, desc = 'Better next word' })
vim.keymap.set('n', 'b', 'B', { desc = 'Better prev word' })
vim.keymap.set('n', 'B', 'b', { noremap = true, desc = 'Better prev word' })
vim.keymap.set('n', 'e', 'E', { desc = 'Better end of next word' })

-- Alt-Up   → move current line up
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>', { desc = 'Move line up' })
-- Alt-Down → move current line down
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>', { desc = 'Move line down' })
-- Alt-Up   → move selected block up
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
-- Alt-Down → move selected block down
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

vim.keymap.set('n', '!', 'V!', { noremap = true, desc = 'Select current line visually when pressing `!`' })

-- Map Ctrl+Alt+q to enter visual block mode
vim.api.nvim_set_keymap('n', '<C-A-q>', '<C-v>', { noremap = true })
-- Map Alt+q to enter visual block mode
vim.api.nvim_set_keymap('n', '<A-q>', '<C-v>', { noremap = true })
-- Map Ctrl+Alt+v to enter visual block mode
vim.api.nvim_set_keymap('n', '<C-A-v>', '<C-v>', { noremap = true })

-- inrease number
vim.keymap.set('n', '<A-a>', '<C-a>', { noremap = true })
vim.keymap.set('n', '<C-A-a>', '<C-a>', { noremap = true })
-- decrease number
vim.keymap.set('n', '<A-x>', '<C-x>', { noremap = true })
vim.keymap.set('n', '<C-A-x>', '<C-x>', { noremap = true })

-- copy chars from above ("up")
vim.keymap.set('i', '<A-u>', '<C-y>', { noremap = true })
vim.keymap.set('n', '<A-u>', 'i<C-y><Esc>l', { noremap = true })
-- copy chars from below ("down")
vim.keymap.set('i', '<A-d>', '<C-e>', { noremap = true })
vim.keymap.set('n', '<A-d>', 'i<C-e><Esc>l', { noremap = true })

-- vv to activate V
vim.keymap.set('n', 'vv', 'V', { noremap = true })

-- vim.keymap.set('i', '<C-n>', function()
-- require('blink.cmp').select_next_item() -- Explicitly call Blink's next-item
-- end, { desc = 'Next completion item' })

-- use original C-n, not blink.cmp's
vim.keymap.set('i', '<C-n>', '<C-n>', { noremap = true, silent = true })
-- use original C-p, not blink.cmp's
vim.keymap.set('i', '<C-p>', '<C-p>', { noremap = true, silent = true })

-- Create the :Hello sample command (must start with a capital letter)
vim.api.nvim_create_user_command('Hello', function()
  vim.cmd "echo 'Hello, World!'"
end, {})

-- Telescope
-- telescope (builtins)
-- vim.keymap.set({ 'n', 'i' }, '<C-t>', require('telescope.builtin').builtin)
vim.keymap.set({ 'n' }, '<leader>t', require('telescope.builtin').builtin)
-- explorer
vim.keymap.set({ 'n', 'i' }, '<C-e>', require('telescope.builtin').find_files)
vim.keymap.set({ 'n' }, '<leader>te', require('telescope.builtin').find_files)
-- help tags
-- vim.keymap.set({ 'n', 'i' }, '<C-h>', require('telescope.builtin').help_tags)  -- used for moving around the panes
vim.keymap.set({ 'n' }, '<leader>th', require('telescope.builtin').help_tags)
-- overview
vim.keymap.set({ 'n', 'o' }, '<C-A-o>', require('telescope.builtin').lsp_document_symbols)
vim.keymap.set({ 'n' }, '<leader>to', require('telescope.builtin').lsp_document_symbols)
-- live grep
vim.keymap.set({ 'n' }, '<leader>tg', require('telescope.builtin').live_grep)

-- LSP
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<F3>', require('telescope.builtin').lsp_definitions, { desc = 'Goto definition' })

-- edit init.lua ("edit rc")
vim.keymap.set('n', '<leader>erc', function()
  local config_path = vim.fn.stdpath 'config' .. '/init.lua'
  vim.cmd('edit ' .. config_path)
end, { desc = 'Open Neovim config' })

-- reload init.lua ("source rc")
vim.keymap.set('n', '<leader>src', function()
  local config_path = vim.fn.stdpath 'config' .. '/init.lua'
  vim.cmd('source ' .. config_path)
  vim.notify('Neovim config reloaded!', vim.log.levels.INFO, { title = 'Config' })
end, { desc = 'Reload Neovim config' })

-- make Ctrl+o and Ctrl+i work in insert mode
-- !!! somehow it conflicted with the TAB (???), so I disabled it
-- vim.keymap.set('i', '<C-o>', '<ESC><C-o>i', { noremap = true })
-- vim.keymap.set('i', '<C-i>', '<ESC><C-i>i', { noremap = true })

-- Press <Esc> twice to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<F11>', ':ZenMode<CR>')
vim.keymap.set('i', '<F11>', '<ESC>:ZenMode<CR>a')

vim.keymap.set('n', '<F4>', ':Twilight<CR>')
vim.keymap.set('i', '<F4>', '<ESC>:Twilight<CR>a')

-- invert
vim.keymap.set({ 'n', 'v' }, '<leader>i', require('nvim-toggler').toggle)

-- Toggle line wrap with F6
vim.keymap.set('n', '<F6>', ':set wrap!<CR>')
