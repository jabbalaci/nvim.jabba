return {
  -- Code Runner
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy', -- load after UIEnter
  keys = { { '<A-r>', mode = { 'n', 'i' } } },
  config = function()
    local Terminal = require('toggleterm.terminal').Terminal

    local function build_cmd()
      local full = vim.fn.expand '%:p'
      if full == '' then
        vim.notify('Save the file first!', vim.log.levels.WARN)
        return "echo 'Error: No filename. Save it first!'"
      end
      -- vim.cmd 'silent write'

      local ext = vim.fn.expand '%:e'
      local fname = vim.fn.expand '%:t' -- /opt/Main.java -> Main.java
      local fname_no_ext = vim.fn.expand '%:t:r' -- /opt/Main.java -> Main
      if ext == 'py' then
        return 'python3 ' .. vim.fn.shellescape(full)
      elseif ext == 'c' then
        return ("gcc '%s' && ./a.out"):format(vim.fn.shellescape(full))
      elseif ext == 'd' then
        return 'rdmd ' .. vim.fn.shellescape(full)
      elseif ext == 'java' then
        local cmd = ('javac %s && java %s'):format(vim.fn.shellescape(fname), vim.fn.shellescape(fname_no_ext))
        return cmd
      elseif ext == 'kt' then
        return 'kscript ' .. vim.fn.shellescape(full)
      else
        return ("echo 'No run rule for extension: .%s'"):format(ext)
      end
    end

    vim.keymap.set({ 'n', 'i' }, '<A-r>', function()
      Terminal:new({
        cmd = build_cmd(),
        direction = 'horizontal',
        close_on_exit = false,
        auto_scroll = true,
      }):toggle()
    end, { desc = 'Run current file' })
  end,
}
