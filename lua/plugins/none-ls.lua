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

      null_ls.setup {
        sources = {
          -- see at https://github.com/nvimtools/none-ls-extras.nvim/tree/main
          require 'none-ls.diagnostics.eslint_d',
          require 'none-ls.code_actions.eslint_d',

          -- TODO: tweak the diagnostics styling
          -- TODO: properly config the cspell.json path
          -- see at https://github.com/davidmh/cspell.nvim
          require 'cspell.diagnostics',
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
