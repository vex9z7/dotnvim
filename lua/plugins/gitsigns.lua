local function is_window_vertical()
  local win_id = vim.api.nvim_get_current_win()
  local width = vim.api.nvim_win_get_width(win_id)
  local height = vim.api.nvim_win_get_height(win_id)
  return 2 * height > width
end

return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })

        -- normal mode
        map(
          'n',
          '<leader>gs',
          gitsigns.stage_hunk,
          { desc = 'git [s]tage hunk' }
        )
        map(
          'n',
          '<leader>gr',
          gitsigns.reset_hunk,
          { desc = 'git [r]eset hunk' }
        )
        map(
          'n',
          '<leader>gS',
          gitsigns.stage_buffer,
          { desc = 'git [S]tage buffer' }
        )
        map(
          'n',
          '<leader>gu',
          gitsigns.stage_hunk,
          { desc = 'git [u]ndo stage hunk' }
        )
        map('n', '<leader>gB', gitsigns.blame(), { desc = 'git [B]lame' })
        map(
          'n',
          '<leader>gR',
          gitsigns.reset_buffer,
          { desc = 'git [R]eset buffer' }
        )
        map(
          'n',
          '<leader>gp',
          gitsigns.preview_hunk_inline,
          { desc = 'git [p]review hunk inline' }
        )

        map('n', '<leader>gd', function()
          local is_vertical = is_window_vertical()
          gitsigns.diffthis(nil, { vertical = not is_vertical })
        end, { desc = 'git [d]iff against index' })

        map('n', '<leader>gD', function()
          local is_vertical = is_window_vertical()
          gitsigns.diffthis('@', { vertical = not is_vertical })
        end, { desc = 'git [D]iff against last commit' })

        -- TODO: manage toggles by snacks.nvim
        -- Toggles
        map(
          'n',
          '<leader>tb',
          gitsigns.toggle_current_line_blame,
          { desc = '[T]oggle git show [b]lame line' }
        )
        map('n', '<leader>tw', gitsigns.toggle_word_diff)
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
