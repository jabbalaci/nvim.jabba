vim.bo.expandtab = true

-- make bold:
-- local groups = {
-- '@keyword.function',
-- '@keyword',
-- 'Statement',
-- 'PreProc',
-- 'Function',
-- 'Type',
-- '@exception',
-- }

-- for _, group in ipairs(groups) do
-- local original = vim.api.nvim_get_hl(0, { name = group }) or {} -- Fallback to empty table
-- Only modify bold attribute, preserve existing color if available
-- vim.api.nvim_set_hl(0, group, {
-- fg = original.fg, -- Keep original color
-- bg = original.bg, -- Keep original background
-- bold = true, -- Force bold
-- default = original.fg == nil, -- Only override if no color exists
-- })
-- end
