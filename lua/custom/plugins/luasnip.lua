return {
  'L3MON4D3/LuaSnip',
  lazy = true,
  -- dependencies = { 'rafamadriz/friendly-snippets' },
  -- config = function()
  -- require('luasnip.loaders.from_vscode').lazy_load()
  -- end,
  config = function()
    require('luasnip').setup {
      -- Your luasnip config here
    }
    -- for snipmate format:
    require('luasnip.loaders.from_snipmate').lazy_load()
  end,
  keys = {
    {
      '<C-h>',
      function()
        require('luasnip').jump(-1)
      end,
      mode = { 'i', 's' },
    },
    {
      '<C-l>',
      function()
        require('luasnip').jump(1)
      end,
      mode = { 'i', 's' },
    },
  },
}
