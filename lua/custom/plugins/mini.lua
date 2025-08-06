return {
  -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    -- require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- Show only filename (no path)
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_filename = function()
      return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
    end

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      -- return '%2l:%-2v'
      local line = vim.fn.line '.'
      local total_lines = vim.fn.line '$'
      local percent = math.floor((line / total_lines) * 100)
      -- return string.format('%2d:%-2d %3d%%%%', line, vim.fn.col '.', percent)
      return string.format('%2d:%-2d %4d%%%%', line, vim.fn.col '.', percent)
    end

    require('mini.trailspace').setup {
      -- Highlight trailing whitespace
      highlight = true,
      -- Only trim in normal buffers (not terminals)
      only_in_normal_buffers = true,
      -- Custom highlight group (optional)
      highlight_group = 'MiniTrailspace',

      vim.api.nvim_set_hl(0, 'MiniTrailspace', { bg = '#FFD1DC' }),
    }

    local jabuci_art = [[
     ██╗ █████╗ ██████╗ ██╗   ██╗ ██████╗██╗
     ██║██╔══██╗██╔══██╗██║   ██║██╔════╝██║
     ██║███████║██████╔╝██║   ██║██║     ██║
██   ██║██╔══██║██╔══██╗██║   ██║██║     ██║
╚█████╔╝██║  ██║██████╔╝╚██████╔╝╚██████╗██║
 ╚════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚═════╝╚═╝
]]

    -- require('mini.starter').setup {
    -- header = jabuci_art,
    -- }

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
