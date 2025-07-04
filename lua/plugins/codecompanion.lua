return {
  'olimorris/codecompanion.nvim',
  opts = {
    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
    strategies = {
      chat = {
        adapter = 'openai',
      },
      inline = {
        adapter = 'openai',
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ravitemer/mcphub.nvim',
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.diff',
  },
}
