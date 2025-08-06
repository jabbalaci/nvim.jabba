local right_width = 0.4

local bottom_height = 0.3

--------------
-- Vertical --
--------------
-- Vertical terminal (right side, toggle with <C-t>)
local term_buf_v = nil
local term_win_v = nil
local has_cleared_v = false -- Track if we've cleared the screen

vim.keymap.set({ 'n', 't' }, '<C-t>', function()
  -- Check if we have a valid terminal window
  if term_win_v and vim.api.nvim_win_is_valid(term_win_v) then
    -- Window exists - close it
    vim.api.nvim_win_close(term_win_v, true)
    term_win_v = nil
  else
    -- No window exists - create or focus terminal
    if term_buf_v and vim.api.nvim_buf_is_valid(term_buf_v) then
      -- Terminal buffer exists but no window - create new window
      vim.cmd 'vsplit'
      vim.api.nvim_win_set_buf(0, term_buf_v)
      term_win_v = vim.api.nvim_get_current_win()
    else
      -- No terminal exists - create new one
      vim.cmd 'vsplit | terminal'
      term_buf_v = vim.api.nvim_get_current_buf()
      term_win_v = vim.api.nvim_get_current_win()
      has_cleared_v = false -- Reset flag for new terminal
    end

    -- Configure window, set width
    vim.api.nvim_win_set_width(term_win_v, math.floor(vim.o.columns * right_width))

    -- Clear screen only on first creation
    if not has_cleared_v then
      vim.defer_fn(function()
        if vim.b.terminal_job_id then
          vim.api.nvim_chan_send(vim.b.terminal_job_id, 'clear\n')
          has_cleared_v = true -- Mark as cleared
        end
      end, 100)
    end

    vim.cmd 'startinsert'
  end
end, { desc = 'Toggle terminal in vertical split' })

----------------
-- Horizontal --
----------------
-- Horizontal terminal (bottom, toggle with <C-A-t>)
local term_buf_h = nil
local term_win_h = nil
local has_cleared_h = false -- Track if we've cleared the screen

vim.keymap.set({ 'n', 't' }, '<C-A-t>', function()
  -- Check if we have a valid terminal window
  if term_win_h and vim.api.nvim_win_is_valid(term_win_h) then
    -- Window exists - close it
    vim.api.nvim_win_close(term_win_h, true)
    term_win_h = nil
  else
    -- No window exists - create or focus terminal
    if term_buf_h and vim.api.nvim_buf_is_valid(term_buf_h) then
      -- Terminal buffer exists but no window - create new window
      vim.cmd 'belowright split'
      vim.api.nvim_win_set_buf(0, term_buf_h)
      term_win_h = vim.api.nvim_get_current_win()
    else
      -- No terminal exists - create new one
      vim.cmd 'belowright split | terminal'
      term_buf_h = vim.api.nvim_get_current_buf()
      term_win_h = vim.api.nvim_get_current_win()
      has_cleared_h = false -- Reset flag for new terminal
    end

    -- Configure window, set height
    vim.api.nvim_win_set_height(term_win_h, math.floor(vim.o.lines * bottom_height))

    -- Clear screen only on first creation
    if not has_cleared_h then
      vim.defer_fn(function()
        if vim.b.terminal_job_id then
          vim.api.nvim_chan_send(vim.b.terminal_job_id, 'clear\n')
          has_cleared_h = true -- Mark as cleared
        end
      end, 100)
    end

    vim.cmd 'startinsert'
  end
end, { desc = 'Toggle terminal in horizontal split' })
