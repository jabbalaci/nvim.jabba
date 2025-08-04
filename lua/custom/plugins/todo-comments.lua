-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim', -- https://github.com/folke/todo-comments.nvim
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
  },
  config = function(_, opts)
    require('todo-comments').setup(opts)

    -- change bg and fg colors to make it more readable
    vim.api.nvim_set_hl(0, 'TodoBgTODO', { bg = '#07879d', fg = '#ffffff' })
    vim.api.nvim_set_hl(0, 'TodoBgNOTE', { bg = '#118c74', fg = '#ffffff' })
  end,
}
