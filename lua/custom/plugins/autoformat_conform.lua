return {
  -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      -- local disable_filetypes = { c = true, cpp = true }
      local disable_filetypes = {}
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 800, -- previous value (before Kotlin) was 500
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_imports', 'ruff_format' }, -- executed top → bottom
      d = { 'dfmt' },
      c = { 'clang_format' },
      cs = { 'clang_format' },
      java = { 'clang_format' },
      json = { 'clang_format' },
      go = { 'gofmt' }, -- leave it like this, don't add under "formatters"
      kotlin = { 'ktlint' },
      fortran = { 'fprettify' },
    },

    formatters = {
      stylua = {
        command = 'stylua',
        args = { '--indent-type', 'Spaces', '--indent-width', '2', '$FILENAME', '-' },
        stdin = true,
      },
      ruff_imports = {
        command = 'ruff',
        args = { 'check', '--fix', '--select=I', '--stdin-filename', '$FILENAME', '-' },
        stdin = true,
      },
      ruff_format = {
        command = 'ruff',
        args = { 'format', '--stdin-filename', '$FILENAME', '-' },
        stdin = true,
      },
      dfmt = {
        command = 'dfmt',
        stdin = true,
      },
      clang_format = {
        command = 'clang-format',
        args = { '--style=Microsoft', '-i', '$FILENAME' },
        stdin = false, -- for in-place formatting
      },
      fprettify = {
        command = 'fprettify',
        args = { '-w', '3', '$FILENAME' }, -- "-w 3": space around '*' and '/'
        stdin = false, -- for in-place formatting
      },
      -- ktlint = {
      -- command = 'ktlint',
      -- args = { '-F', '$FILENAME' },
      -- stdin = true, -- for in-place formatting
      -- },
    },
  },
}
