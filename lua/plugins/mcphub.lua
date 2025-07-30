return {
  'ravitemer/mcphub.nvim',
  -- FIXME: reify to compatiable versions
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  build = 'bundled_build.lua', -- Bundles `mcp-hub` binary along with the neovim plugin
  config = function()
    require('mcphub').setup {
      use_bundled_binary = true, -- Use local `mcp-hub` binary
    }
  end,
}
