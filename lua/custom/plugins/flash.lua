return {
  -- jump to anywhere on the screen
  'folke/flash.nvim',
  event = 'VeryLazy',
  dependencies = { 'tpope/vim-repeat' },
  ---@type Flash.Config
  opts = {
    highlight = {
      -- Custom highlight groups
      -- matches = false, -- disable built-in highlights
      groups = {
        match = 'FlashMatch',
        current = 'FlashCurrent',
        label = 'FlashLabel',
      },
    },
  },
  config = function(_, opts)
    -- Set custom highlight groups before setup
    -- good:
    -- vim.api.nvim_set_hl(0, 'FlashMatch', { fg = '#FFA500', bg = '#2E3440' }) -- Orange
    -- vim.api.nvim_set_hl(0, 'FlashCurrent', { fg = '#FFFFFF', bg = '#BF616A' }) -- White on red
    -- vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#FFFFFF', bg = '#5E81AC', bold = true }) -- White on blue

    -- my tweaks:
    vim.api.nvim_set_hl(0, 'FlashMatch', { fg = '#000000', bg = '#A7C7E7' }) -- Black on blue
    vim.api.nvim_set_hl(0, 'FlashCurrent', { fg = '#000000', bg = '#A7C7E7' }) -- Black on blue
    vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#000000', bg = '#FFB7C5', bold = true }) -- Black on pink

    require('flash').setup(opts)
  end,
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },

    -- for f and F I want the original functionality
    vim.keymap.set('n', 'f', 'f', { noremap = true })

    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
