local function cbfmtSourceFactory()
  local helpers = require 'null-ls.helpers'
  local methods = require 'null-ls.methods'

  local FORMATTING = methods.internal.FORMATTING
  local CBFMT_CONFIG_PATH = vim.fn.expand '~/.config/nvim/tool-config/cbfmt.toml'

  return helpers.make_builtin {
    name = 'cbfmt',
    meta = {
      url = 'https://github.com/lukas-reineke/cbfmt',
      description = 'A tool to format codeblocks inside markdown and org documents.',
    },
    method = FORMATTING,
    filetypes = { 'markdown', 'org' },
    generator_opts = {
      command = 'cbfmt',
      args = {
        '--stdin-filepath',
        '$FILENAME',
        '--best-effort',
        '--config',
        CBFMT_CONFIG_PATH,
      },
      to_stdin = true,
      condition = true,
    },
    factory = helpers.formatter_factory,
  }
end

return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvimtools/none-ls-extras.nvim', 'davidmh/cspell.nvim' },
    config = function()
      local null_ls = require 'null-ls'

      vim.diagnostic.config {
        underline = {
          severity = {
            min = vim.diagnostic.severity.HINT, -- INFO: underline for all severity
          },
        },
      }

      null_ls.setup {
        sources = {
          -- see at https://github.com/nvimtools/none-ls-extras.nvim/tree/main
          require 'none-ls.diagnostics.eslint_d',
          require 'none-ls.code_actions.eslint_d',

          -- see at https://github.com/davidmh/cspell.nvim
          require('cspell.diagnostics').with {
            diagnostic_config = {
              -- see at :help vim.diagnostic.config()
              underline = true,
              virtual_text = true,
              signs = false,
              update_in_insert = false,
              severity_sort = true,
            },

            diagnostics_postprocess = function(diagnostic)
              -- see :help diagnostic-severity
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,

            -- TODO: properly config the cspell.json path
            -- config = {
            --   find_json = function(cwd)
            --     local CSPELL_FALLBACK_CONFIG_PATH = vim.fn.expand '~/.config/nvim/tool-config/cspell.json'
            --     return CSPELL_FALLBACK_CONFIG_PATH
            --   end,
            -- },
          },

          require 'cspell.code_actions',

          -- TODO: migrate to conform
          -- -- shell
          -- formatting.shfmt,

          -- TODO: migrate to inject formatting of conform
          -- Markdown
          cbfmtSourceFactory(),
        },
      }
    end,
  },
}
