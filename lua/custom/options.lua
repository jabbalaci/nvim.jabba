-- start in insert mode
-- vim.cmd 'startinsert'

-- Make line numbers default
vim.o.number = true
-- relative numbers
vim.o.relativenumber = false
-- vim.o.relativenumber = true

-- Show which line your cursor is on
vim.o.cursorline = true

-- when pressing n (next), stop at the last occurence
-- if true (default), it goes around in a cyclic way
-- vim.o.wrapscan = false

-- Enable % matching for < > and « »'
vim.opt.matchpairs:append '<:>' -- Append to default pairs
vim.opt.matchpairs:append '«:»' -- Append to default pairs
