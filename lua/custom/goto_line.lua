local M = {}

local function clear_statusline(delay_ms)
  delay_ms = delay_ms or 1000 -- Default to 1000ms if nil/false
  vim.defer_fn(function()
    vim.notify ''
  end, delay_ms)
end

function M.jump()
  local max_line = vim.fn.line '$'

  vim.ui.input({ prompt = string.format('Go to line (1 - %d): ', max_line) }, function(input)
    if not input then
      return
    end

    if input == '' then
      clear_statusline()
      return
    end

    local line
    if input:sub(-1, -1) == '%' then
      local percent = tonumber(input:sub(1, -2))
      if not percent then
        vim.notify('Wrong value', vim.log.levels.ERROR)
        clear_statusline(1500)
        return
      end
      line = math.floor((percent * max_line) / 100 + 0.5) -- rounding
    else
      line = tonumber(input)
      if not line then
        vim.notify('Wrong value', vim.log.levels.ERROR)
        clear_statusline(1500)
        return
      end
    end

    if line < 1 then -- 0 or negative indexing, -1 is the last line
      if line == 0 then
        line = 1
      else
        line = max_line + line + 1
        if line < 1 then -- if it's still negative
          line = 1
        end
      end
    end
    if line > max_line then
      line = max_line
    end

    vim.api.nvim_win_set_cursor(0, { line, 0 })
    vim.notify ''
  end)
end

vim.keymap.set('n', '<C-g>', M.jump, { desc = 'Jump to line' })

return M
