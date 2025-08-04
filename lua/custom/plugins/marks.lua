return {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  config = function()
    require('marks').setup {
      mappings = {
        set_next = 'm+',
        delete_line = 'm-',
        delete_buf = 'm*',
        toggle = 'mm',
        next = '<A-n>',
        prev = '<A-p>',
        preview = 'mp',
        -- prev = false, -- pass false to disable only this default mapping
      },
    }
  end,
}
