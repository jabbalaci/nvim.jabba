return {
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      styles = {
        comments = { italic = false }, -- Disable italics in comments
      },
    }

    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    -- vim.cmd.colorscheme 'tokyonight-night'
    vim.cmd.colorscheme 'tokyonight-day'

    -- some customizations of mine:

    -- override the yank-flash colour
    -- vim.api.nvim_set_hl(0, 'IncSearch', { fg = '#000000', bg = '#9bdbff', bold = true })  -- light blue
    vim.api.nvim_set_hl(0, 'IncSearch', { fg = '#000000', bg = '#b8f2b2', bold = true }) -- light green
    -- darker grey background for the number column
    vim.api.nvim_set_hl(0, 'LineNr', { bg = '#e1e2e7', fg = '#000000' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = '#eeeeee', fg = '#b15c00', bold = true })
    -- current, highlighted line
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#e4e4e4' })
    -- Override the background color of the canvas
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#eeeeee' }) -- Set your desired background color here
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#eeeeee' }) -- Set the same color for floating windows
    -- the funny ~ chars after the last line:
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = '#a8aecb' })

    -- make these bold:
    local groups = {
      '@keyword',
      '@keyword.function',
      '@keyword.import',
      '@include',
      'Statement',
      'PreProc',
      'Type',
      -- '@function.builtin.python',
      '@type.builtin',
      '@exception',
    }

    for _, group in ipairs(groups) do
      local original = vim.api.nvim_get_hl(0, { name = group }) or {} -- Fallback to empty table
      -- Only modify bold attribute, preserve existing color if available
      vim.api.nvim_set_hl(0, group, {
        fg = original.fg, -- Keep original color
        bg = original.bg, -- Keep original background
        bold = true, -- Force bold
        default = original.fg == nil, -- Only override if no color exists
      })
    end
  end,
}
