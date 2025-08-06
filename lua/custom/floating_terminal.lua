-- based on https://www.youtube.com/watch?v=5PIiKDES_wc

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

-- open_float(opts)
-- opts = { width = <float|int>, height = <float|int> } (optional)
local function open_float(opts)
  opts = opts or {}

  local ui = vim.api.nvim_list_uis()[1]
  local w = opts.width or 0.8
  local h = opts.height or 0.8

  -- turn floats >1 into absolute cell counts
  w = w > 1 and w or math.floor(ui.width * w)
  h = h > 1 and h or math.floor(ui.height * h)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- scratch, unlisted
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = w,
    height = h,
    col = (ui.width - w) / 2,
    row = (ui.height - h) / 2,
    style = 'minimal', -- no number column etc.
    border = 'rounded',
  })

  -- optional: return buf, win so the caller can fill the buffer
  return { buf = buf, win = win }
end

vim.keymap.set({ 'n', 't' }, '<A-t>', function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = open_float { buf = state.floating.buf }
    if vim.api.nvim_get_option_value('buftype', { buf = state.floating.buf }) ~= 'terminal' then
      vim.cmd.term()
      vim.defer_fn(function()
        vim.api.nvim_chan_send(vim.b.terminal_job_id, 'clear\n')
      end, 50)
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end

  vim.cmd 'startinsert'
end)
