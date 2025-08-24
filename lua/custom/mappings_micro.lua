-- Key mappings that make vim similar to micro, i.e.
-- here I want to mimic functionalities that are
-- well-known in other (mainly GUI) editors.

-- quit with Ctrl+q
vim.keymap.set('n', '<C-q>', ':q<CR>', { silent = true })
vim.keymap.set({ 'i', 'v' }, '<C-q>', '<ESC>:q<CR>', { silent = true })
vim.keymap.set('n', '<F10>', ':q<CR>', { silent = true })
vim.keymap.set({ 'i', 'v' }, '<F10>', '<ESC>:q<CR>', { silent = true })
vim.keymap.set('n', 'Q', ':q!<CR>', { silent = true }) -- force quit

-- duplicate line with Ctrl+d
vim.keymap.set('n', '<C-d>', 'yyp')
vim.keymap.set('i', '<C-d>', '<Esc>yypi')

-- save with Ctrl+s
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>a')
vim.keymap.set('v', '<C-s>', '<ESC>:w<CR>gv')
-- enter command-line mode
-- vim.keymap.set({ 'n', 'i', 'v' }, '<C-e>', ':')

-- find with Ctrl+f
vim.keymap.set('n', '<C-f>', '/')
vim.keymap.set('i', '<C-f>', function()
  -- Exit insert mode and show the / prompt immediately
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>/', true, false, true), 'n', true)
end, { desc = 'Exit insert and enter search' })

-- cut line with Ctrl+x
vim.keymap.set('n', '<C-x>', 'dd')
vim.keymap.set('v', '<C-x>', 'd')
vim.keymap.set('i', '<C-x>', '<Esc>ddi')

-- select all with Ctrl+a
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set({ 'i', 'v' }, '<C-a>', '<ESC>ggVG', { desc = 'Select all' })

-- HOME behaves similar to micro
-- vim.keymap.set('n', '<Home>', '^', { desc = 'Jump to first non-whitespace character in the line' })
-- vim.keymap.set('i', '<Home>', '<Esc>^i', { desc = 'Jump to first non-whitespace character in the line' })
local function smart_home()
  local line = vim.fn.getline '.'
  local col0 = vim.fn.col '.' - 1 -- 0-based
  local prefix = line:sub(1, col0)

  local target
  if col0 == 0 then
    target = vim.fn.match(line, '\\S') -- already on col 0 → ^ jump
  elseif prefix:match '^%s*$' then
    target = 0 -- left of cursor is all white → 0
  else
    target = vim.fn.match(line, '\\S') -- default → ^
  end
  vim.fn.cursor('.', target + 1)
end
-- normal / visual / insert
vim.keymap.set({ 'n', 'x', 'i' }, '<Home>', smart_home, { silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
-- vim.keymap.set({ 't', 'i' }, '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true })
-- vim.keymap.set({ 't', 'i' }, '<C-j>', '<C-\\><C-n><C-w>j', { noremap = true })
-- vim.keymap.set({ 't', 'i' }, '<C-k>', '<C-\\><C-n><C-w>k', { noremap = true })
-- vim.keymap.set({ 't', 'i' }, '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true })
-- vim.keymap.set({ 'n' }, '<C-h>', '<C-w>h', { noremap = true })
-- vim.keymap.set({ 'n' }, '<C-j>', '<C-w>j', { noremap = true })
-- vim.keymap.set({ 'n' }, '<C-k>', '<C-w>k', { noremap = true })
-- vim.keymap.set({ 'n' }, '<C-l>', '<C-w>l', { noremap = true })

-- Disable the terminal suspend key and make <C-z> do undo
vim.cmd [[
  silent !stty susp undef 2>/dev/null   " stop the terminal from intercepting <C-z>
]]
-- Ctrl-Z  → undo
vim.keymap.set({ 'n', 'i', 'v' }, '<C-z>', function()
  vim.cmd 'normal! u'
end, { desc = 'Undo' })
-- Ctrl-Y  → redo
vim.keymap.set('n', '<C-y>', '<C-r>', { desc = 'Redo' })
vim.keymap.set('i', '<C-y>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc><C-r>i', true, false, true), 'n', true)
end, { desc = 'Redo' })

-- close the current tab
-- vim.keymap.set('n', '<C-w>', function()
-- vim.cmd 'bdelete' -- or :bdelete!
-- end, { desc = 'Close buffer' })
-- C-w is used by vim, so let's use this indstead:
vim.keymap.set('n', '<C-A-w>', function()
  vim.cmd 'bdelete' -- or :bdelete!
end, { desc = 'Close buffer' })

-- these use the bufferline plugin
-- Alt + PgDn  → next buffer (in visual order)
vim.keymap.set({ 'n', 'i', 'v' }, '<A-Pagedown>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
-- Alt + PgUp  → previous buffer (in visual order)
vim.keymap.set({ 'n', 'i', 'v' }, '<A-PageUp>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
-- Alt + Left  → move current buffer one position to the left
vim.keymap.set({ 'n', 'i', 'v' }, '<A-Left>', '<Cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer left' })
-- Alt + Right → move current buffer one position to the right
vim.keymap.set({ 'n', 'i', 'v' }, '<A-Right>', '<Cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer right' })

-- copy with Ctrl+c
vim.keymap.set('v', '<C-c>', function()
  local save_pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd 'normal! y'
  vim.api.nvim_win_set_cursor(0, save_pos)
end, { desc = 'Copy to clipboard' })

-- paste with Ctrl+v
vim.keymap.set({ 'n', 'v' }, '<C-v>', function()
  vim.cmd 'normal! gp'
end, { desc = 'Paste from clipboard' })
vim.keymap.set('i', '<C-v>', '<Esc>pa', { desc = 'Paste from clipboard' })

-- TAB / S-TAB to indent/out-dent while keeping the selection
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent & keep visual' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Un-indent & keep visual' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent & keep visual' })
vim.keymap.set('v', '<', '<gv', { desc = 'Un-indent & keep visual' })
vim.keymap.set('n', '<Tab>', '>>', { desc = 'Indent current line' })
vim.keymap.set('n', '<S-Tab>', '<<', { desc = 'Un-indent current line' })
vim.keymap.set('n', '<C-i>', '<C-i>', { noremap = true, desc = 'Jump forward' }) -- Explicitly restore <C-i>
vim.keymap.set('i', '<S-Tab>', function()
  -- Save current cursor position (row, col)
  local original_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = original_pos[1], original_pos[2]
  -- Execute the de-indent
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  vim.fn.feedkeys('<<', 't')
  vim.fn.feedkeys('i', 't')
  -- Calculate new column position (4 columns left)
  local new_col = col - 4 + 1
  -- Ensure column doesn't go negative
  new_col = math.max(1, new_col)
  -- Restore cursor to adjusted position
  vim.api.nvim_win_set_cursor(0, { row, new_col })
end, { desc = 'De-indent line and move cursor left' })

-- Enable selectmode to allow Shift + arrow keys to select text
vim.opt.selectmode:append 'key'

vim.keymap.set('n', '<S-Left>', 'v', { desc = 'Go to visual mode' })
vim.keymap.set('n', '<S-Right>', 'v', { desc = 'Go to visual mode' })
vim.keymap.set('v', '<S-Right>', '<Right>')
vim.keymap.set('v', '<S-Left>', '<Left>')

-- vim.keymap.set('n', '<S-Up>', 'v', { desc = 'Go to visual mode' })
-- vim.keymap.set('n', '<S-Down>', 'v', { desc = 'Go to visual mode' })

vim.keymap.set('n', '<S-End>', 'v$', { desc = 'Select until the end of the line' })
vim.keymap.set('n', '<S-Home>', 'v^', { desc = 'Select until the beginning of the line' })
vim.keymap.set('i', '<S-End>', '<Esc>v$', { desc = 'Select until the end of the line' })
vim.keymap.set('i', '<S-Home>', '<Esc>v^', { desc = 'Select until the beginning of the line' })

vim.keymap.set('n', '<S-Up>', 'V')
vim.keymap.set('n', '<S-Down>', 'V')
vim.keymap.set('v', '<S-Up>', '<Up>')
vim.keymap.set('v', '<S-Down>', '<Down>')

-- toggle current line (comment / uncomment)
vim.keymap.set('n', '<C-/>', function()
  vim.fn.feedkeys('gcc', 't')
  -- Move cursor down after a short delay (50ms)
  vim.defer_fn(function()
    vim.cmd 'normal! j'
  end, 50)
end)
vim.keymap.set('i', '<C-/>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  vim.fn.feedkeys('gcc', 't')
  -- Move cursor down after a short delay (50ms)
  vim.defer_fn(function()
    vim.cmd 'normal! j'
  end, 50)
  vim.fn.feedkeys('i', 't')
end)
-- toggle selection (comment / uncomment)
vim.keymap.set('v', '<C-/>', function()
  local start_line = vim.fn.line 'v'
  local end_line = vim.fn.line '.'
  -- Ensure proper order (start <= end)
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  vim.fn.feedkeys('gc', 't')
  -- Move cursor down after a short delay (50ms)
  vim.defer_fn(function()
    vim.api.nvim_win_set_cursor(0, { end_line + 1, 0 })
  end, 50)
end)

-- surround visual selection with ( [ { ' ` *
-- to surround with "..." and <...>, use my plugin `surround`
for _, open in ipairs { '{', '(', '[', "'", '`', '*' } do
  local close = ({ ['{'] = '}', ['('] = ')', ['['] = ']', ["'"] = "'", ['`'] = '`', ['*'] = '*' })[open]
  vim.keymap.set('v', open, 'c' .. open .. [[<C-R>"]] .. close .. '<Esc>', { noremap = true, silent = true })
end

-- vim.keymap.set('n', '<A-l>', function()
-- require('custom.my_plugin').echo_test()
-- end, { desc = 'Echo test' })

-- vim.keymap.set('n', '<C-g>', function()
--   require('custom.goto_line').jump()
-- end, { desc = 'Jump to line' })

local function smart_right_arrow()
  if vim.fn.col '.' + 1 >= vim.fn.col '$' then
    if vim.fn.line '.' < vim.fn.line '$' then
      vim.cmd 'normal! j0'
    end
  else
    vim.cmd 'normal! l'
  end
end
-- Right arrow at the end of a line moves to the beginning of the next line
vim.keymap.set({ 'n', 'i', 'v' }, '<Right>', smart_right_arrow, { desc = 'Smart right arrow' })

local function smart_left_arrow()
  if vim.fn.col '.' == 1 then
    if vim.fn.line '.' > 1 then
      vim.cmd 'normal! k$'
    end
  else
    vim.cmd 'normal! h'
  end
end
-- Left arrow at the beginning of a line moves to the end of the previous line
vim.keymap.set({ 'n', 'i', 'v' }, '<Left>', smart_left_arrow, { desc = 'Smart left arrow' })
