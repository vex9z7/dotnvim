local function cbfmtSourceFactory()
  local helpers = require 'null-ls.helpers'
  local methods = require 'null-ls.methods'

  local FORMATTING = methods.internal.FORMATTING
  local CBFMT_CONFIG_PATH = _G.TOOL_CONFIG_DIR .. '/cbfmt.toml'

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
  -- INFO: mainly used for unifying the diagnostics and the code action
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls-extras.nvim',
    'davidmh/cspell.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    vim.diagnostic.config {
      underline = {
        severity = {
          -- HACK: enable underline highlight for diagnostic
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
      },
    }

    local cspell_config = {
      cspell_config_dirs = { _G.TOOL_CONFIG_DIR },
    }

    null_ls.setup {
      sources = {
        -- see at https://github.com/nvimtools/none-ls-extras.nvim/tree/main
        require 'none-ls.diagnostics.eslint_d',
        require 'none-ls.code_actions.eslint_d',

        -- see at https://github.com/davidmh/cspell.nvim
        -- INFO: disabled because it add too much computtion burden
        -- require('cspell.diagnostics').with {
        --   diagnostic_config = {
        --     -- see at :help vim.diagnostic.config()
        --     underline = true,
        --     signs = true,
        --     virtual_text = false,
        --     update_in_insert = false,
        --     severity_sort = true,
        --   },
        --   diagnostics_postprocess = function(diagnostic)
        --     -- see :help diagnostic-severity
        --     diagnostic.severity = vim.diagnostic.severity.INFO
        --   end,
        --   config = cspell_config,
        -- },
        -- require('cspell.code_actions').with { config = cspell_config },

        -- TODO: migrate to conform
        -- -- shell
        -- formatting.shfmt,

        -- TODO: migrate to inject formatting of conform
        -- Markdown
        cbfmtSourceFactory(),
      },
    }
  end,
}
