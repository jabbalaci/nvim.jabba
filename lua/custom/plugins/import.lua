return {
  'piersolenski/import.nvim',
  dependencies = {
    -- One of the following pickers is required:
    'nvim-telescope/telescope.nvim',
    -- 'folke/snacks.nvim',
    -- 'ibhagwan/fzf-lua',
  },
  opts = {
    picker = 'telescope',
    insert_at_top = false,
  },
  keys = {
    {
      '<leader><leader>',
      function()
        require('import').pick()
      end,
      desc = 'Import',
    },
  },
}
