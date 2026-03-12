HAS_SET_OPENAI_TOKEN = vim.env.OPENAI_API_KEY and vim.env.OPENAI_API_KEY ~= ''

return {
  'olimorris/codecompanion.nvim',
  enabled = HAS_SET_OPENAI_TOKEN,
  opts = {
    extensions = {
      -- FIXME: reify to compatible versions
      -- mcphub = {
      --   callback = 'mcphub.extensions.codecompanion',
      --   opts = {
      --     make_vars = true,
      --     make_slash_commands = true,
      --     show_result_in_chat = true,
      --   },
      -- },
    },
    strategies = {
      chat = {
        adapter = 'openai',
      },
      inline = {
        adapter = 'openai',
      },
    },
    display = {
      chat = {
        window = {
          layout = 'horizontal',
          position = 'bottom',
          border = 'single',
          height = 0.5,
        },
        token_count = function(tokens, adapter)
          return ' (' .. tokens .. ' tokens)'
        end,
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'ravitemer/mcphub.nvim',
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.diff',
  },
}
