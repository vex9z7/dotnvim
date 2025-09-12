local function setup_mini_diff()
  require('mini.diff').setup {
    -- disable all default mappings
    mappings = {
      apply = '',
      reset = '',
      textobject = '',
      goto_first = '',
      goto_prev = '',
      goto_next = '',
      goto_last = '',
    },
  }

  vim.keymap.set('n', '<leader>tp', function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo.buftype == '' and vim.api.nvim_buf_is_loaded(bufnr) then
      require('mini.diff').toggle_overlay(bufnr)
    end
  end, { desc = '[t]oggle inline git diff [p]review' })
end

return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      setup_mini_diff()

      require('mini.git').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
