-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers and relative number default
vim.o.number = true
vim.o.relativenumber = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'

  -- INFO: Configure Neovim to use OSC52 for clipboard operations in ssh terminals
  if vim.env.SSH_TTY then
    vim.g.clipboard = 'osc52'

    local osc52 = require 'vim.ui.clipboard.osc52'
    vim.g.clipboard = {
      name = 'osc52',
      copy = {
        ['+'] = osc52.copy '+',
        ['*'] = osc52.copy '*',
      },
      paste = {
        ['*'] = function()
          return vim.fn.getreg '"'
        end,
        ['+'] = function()
          return vim.fn.getreg '"'
        end,
      },
    }
  end
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.undodir = vim.env.HOME .. '/.config/nvim/undo'

-- number of undo saved
vim.o.undolevels = 10000
vim.o.undoreload = 10000

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = false

-- Disable swap file and backup
vim.o.swapfile = false
vim.o.backup = false

-- Enable incremental search: shows match results as you type
vim.o.incsearch = true
-- Live preview of :substitute (:%s///) command results without splitting the window
vim.o.inccommand = 'nosplit'

vim.o.termguicolors = true

-- Disable hard wrapping: lines won't auto-break at a set width when typing
vim.o.textwidth = 0
-- Enable soft wrapping: long lines wrap visually, not in the file
vim.o.wrap = true
-- Wrap at word boundaries instead of mid-word
vim.o.linebreak = true
-- Show this symbol at the start of wrapped lines for clarity
vim.o.showbreak = ' 󱞩 '

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd 'highlight Visual term=bold,italic gui=bold,italic'
  end,
})

-- INFO: set the tool config path
_G.TOOL_CONFIG_DIR = (vim.fn.stdpath 'config') .. '/tool-config/'
