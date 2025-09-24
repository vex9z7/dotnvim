return {
  'stevearc/conform.nvim', -- Autoformat
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true }
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
      local disable_filetypes = {}
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {}
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'eslint_d', 'prettierd' },
      javascriptreact = { 'eslint_d', 'prettierd' },
      typescript = { 'eslint_d', 'prettierd' },
      typescriptreact = { 'eslint_d', 'prettierd' },
      python = { 'darker' },
      rust = { 'rustfmt' },
      css = { 'stylelint', 'prettierd' },
      less = { 'stylelint', 'prettierd' },
      json = { 'prettierd' },
      jsonc = { 'prettierd' },
      yaml = { 'prettierd' },
      markdown = { 'prettierd' },
      mdx = { 'prettierd' },
      graphql = { 'prettierd' },
    },
    default_format_opts = { timeout_ms = 1500, lsp_format = 'fallback' },
  },
}
