return {
  -- tabs
  'akinsho/bufferline.nvim',
  version = '*', -- or pin a tag
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        indicator = { style = 'icon' },
        diagnostics = 'nvim_lsp',
        show_close_icon = true,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left',
            separator = true,
          },
        },
      },
    }
  end,

  -- Create the :This command (must start with a capital letter)
  -- vim.api.nvim_create_user_command('This', function()
  -- vim.cmd 'BufferLineCloseOthers'
  -- vim.cmd 'only'
  -- end, {}),
}
