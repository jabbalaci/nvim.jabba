vim.bo.expandtab = false -- Use literal tabs
vim.bo.tabstop = 4 -- Tab displays as 4 chars wide
vim.bo.shiftwidth = 4 -- Indent size matches tabstop

-- expand folds:
vim.opt_local.foldmethod = 'marker' -- Ensure folds are recognized
vim.opt_local.foldlevel = 99 -- Expands ALL folds
