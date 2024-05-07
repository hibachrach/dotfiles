-- vim.lsp.set_log_level("DEBUG")

-- Set up Plugin Manager (Lazy.nvim) & list plugins {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    -- Enforcing sane behavior
    'tpope/vim-repeat',                -- Make `.` work like it should
    'tpope/vim-endwise',               -- Automatically add `end` when in Ruby
    -- 'Townk/vim-autoclose',             -- Automatic closure of parens, braces, and brackets
    { dir = '~/personal/traces.vim' }, -- Highlight patterns and ranges for Ex-commands

    -- UI - Plugins that don't *do* anything but display information
    'junegunn/vim-peekaboo', -- To see vim register contents during reg access
    {
      'RRethy/vim-hexokinase',
      build = 'make hexokinase',
    }, -- Show colors for hexcodes in sign column

    -- Colorschemes
    'nvim-treesitter/nvim-treesitter',
    'navarasu/onedark.nvim',

    -- File Navigation
    {
      "junegunn/fzf",
      dir = "~/.fzf",
      build = "./install --all"
    },
    'junegunn/fzf.vim', -- Fuzzy file search (hooked up to C-P for me)


    -- Editor Keybindings/Motions
    'tpope/vim-unimpaired',      -- Pairs of useful keymappings
    'tpope/vim-commentary',      -- Easily (un)comment lines or blocks
    'wellle/targets.vim',        -- Add additional text objects and related goodies
    'junegunn/vim-easy-align',   -- To easily align repeating structures
    'tpope/vim-surround',        -- Easily add surrounding characters to text objects
    'AndrewRadev/splitjoin.vim', -- Easily transition between one-line & multiline statements
    'AndrewRadev/switch.vim',    -- Easily switch between states/formats for various things

    -- Advanced text manipulation
    'tpope/vim-abolish', -- Case-smart replacement; case coercion
    'chrisbra/unicode.vim',

    -- Interfaces
    'tpope/vim-eunuch',               -- Adds nice Unix shortcuts to Vim
    'tpope/vim-fugitive',             -- Git wrapper for vim
    'tpope/vim-rhubarb',              -- Enable vim-fugitive to browse stuff on GitHub
    'junegunn/gv.vim',                -- Enable easy git log browsing
    'janko-m/vim-test',               -- Running tests in vim
    'benmills/vimux',                 -- Send commands to tmux panes from vim; used in vim-test
    'airblade/vim-gitgutter',         -- Show changes in the left gutter; stage individual hunks
    'christoomey/vim-tmux-navigator', -- Enables vim-tmux nav with C-h/j/k/l keys
    'jpalardy/vim-slime',             -- Send commands over to another tmux pane!

    {
      dir = '~/personal/programming/forks/vim-github-codeowners',
      build = 'npm install'
    },

    -- Autocompletion
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'jose-elias-alvarez/null-ls.nvim',
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    'hrsh7th/nvim-cmp',
    -- 'folke/neodev.nvim',

    -- Not for Vim - Plugins that don't have anything to do with vim (weird, right?)
    'edkolev/tmuxline.vim',   -- Customize tmux status bar in .vimrc
    'edkolev/promptline.vim', -- Customize shell prompt

    -- Language/library specific plugins
    'jparise/vim-graphql',
    'tpope/vim-bundler', -- Additional help with bundler and external gems
    'tpope/vim-rails',   -- Additional rails help
    'rlue/vim-fold-rspec',
    {
      'groenewege/vim-less',
      ft = 'less'
    },
    {
      'rust-lang/rust.vim',
      ft = 'rust',
    },
    'elixir-editors/vim-elixir',
    'neoclide/jsonc.vim',
    'ChrisWellsWood/roc.vim',
    'LhKipp/nvim-nu',
    'nvim-lua/plenary.nvim',
    'hashivim/vim-terraform'
  },
  {
    ui = {
      icons = {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
    }
  }
)

-- }}}
-- Basic configuration {{{
vim.opt.number = true                             -- Show line numbers
vim.opt.spell = true
vim.opt.spelllang = 'en_us'                       -- Spellcheck (in comments & strings)
vim.opt.hidden = true                             -- Allow for changing buffers even if current has unsaved changes
vim.opt.expandtab = true                          -- Expand each press of <TAB> to appropriate number of spaces
vim.opt.tabstop = 2                               -- Number of spaces each tab corresponds to
vim.opt.shiftwidth = 2                            -- Number of spaces to indent to when using autoformatting
vim.opt.cursorline = true                         -- Highlight the line the cursor is on
vim.opt.ignorecase = true                         -- Ignore case when searching
vim.opt.smartcase = true                          -- Add case sensitivity if any capital letters; requires ignorecase
vim.opt.showmode = true                           -- Don't show the mode (INSERT, VISUAL, etc.) on the last line
vim.opt.splitright = true                         -- So new splits open on the right
vim.opt.undofile = true                           -- Keep undos in a file
vim.opt.undodir = vim.fn.expand('~/.vim/undodir') -- Sets undo file director
vim.opt.undolevels = 1000                         -- Max number of changes that can be undone
vim.opt.undoreload = 10000                        -- Save files <10,000 lines as an undo before executing :e!
vim.opt.swapfile = false                          -- Swap files aren't really necessary with git and undofiles
vim.opt.showtabline = 2                           -- Always show tab list; utilized by bufferline to show buffers
vim.opt.cmdwinheight = 1
vim.opt.mouse:append('a')
vim.opt.shell = 'zsh'
vim.opt.colorcolumn = '80'
require('onedark').load()

vim.env.ruby_fold = 1
vim.env.ruby_foldable_groups = 'class module def do if'

local currentmode = {
  n      = 'N',
  no     = 'N·Op Pending',
  v      = 'V',
  V      = 'VLine',
  ['']  = 'VBlock',
  s      = 'Select',
  S      = 'S·Line',
  x19    = 'S·Block',
  i      = 'I',
  R      = 'R',
  Rv     = 'VReplace',
  c      = 'Command',
  cv     = 'Vim Ex',
  ce     = 'Ex',
  r      = 'Prompt',
  rm     = 'More',
  ['r?'] = 'Confirm',
  ['!']  = 'Shell',
  t      = 'Terminal'
}

local function status_diagnostic()
  -- local info = vim.b.coc_diagnostic_info
  if not info or #info == 0 then
    return ''
  end
  local msgs = {}
  if info.error then
    table.insert(msgs, 'E' .. info.error)
  end
  if info.warning then
    table.insert(msgs, 'W' .. info.warning)
  end
  if info.information then
    table.insert(msgs, 'I' .. info.information)
  end
  if #msgs == 0 then
    return '[✓]'
  end
  return '[' .. table.concat(msgs) .. ']'
end

BuildStatusline = function()
  local vim_mode = currentmode[vim.fn.mode()] or '?'
  local codeowner = vim.fn['codeowners#who'](vim.api.nvim_buf_get_name(0))
  local relative_path = vim.fn.expand('%:~:.')
  local parts = {
    '[',
    vim_mode,
    ']',
    status_diagnostic(),
    ' ',
    '%<',          -- truncate here if too long
    relative_path, -- filename
    ' ',
    '%h',          -- help text indicator
    '%m',          -- modifiable flag
    '%r',          -- read only flag
    '[',
    codeowner,
    ']',
    '%=',    -- alignment break
    '%y',    -- filetype
    '%14.(', -- start of group (which must be minimum of 14 characters)
    '[',
    '%l',    -- line number
    '/',
    '%L',    -- number of lines in buffer
    ':',
    '%v',    -- "virtual" column number (number of visual chars from left)
    ']',
    '%)',    -- end of group
    ' ',
    '%P',    -- percent of the way through file
  }
  return table.concat(parts)
end

vim.opt.statusline = '%!v:lua.BuildStatusline()'

-- Good for lightweight error format detection from arbitrary sources
-- For some reason, can't use `append` method as errorformat string has already
-- been built/concatenated
vim.o.errorformat = vim.o.errorformat .. ',%f:%l'
vim.opt.grepprg = 'rg --vimgrep --no-heading'
vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'

vim.opt.inccommand = 'nosplit' -- Show replaced string *while* typing!
vim.opt.showmode = false       -- Hide "-- INSERT --" and the like
vim.opt.guicursor = nil        -- Always use a 1 char block as cursor

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    -- Highlights the region that was just yanked
    vim.highlight.on_yank()
  end
})

-- }}}
-- Keymappings {{{

vim.keymap.set({ 'n', 'v' }, '<space>', '<leader>', { remap = true })
-- Move to next buffer
vim.keymap.set('n', '<leader>l', function() vim.cmd('bnext') end)
-- Move to previous buffer
vim.keymap.set('n', '<leader>h', function() vim.cmd('bprevious') end)
-- Easily edit configs
vim.keymap.set('n', '<leader>ve', function() vim.cmd('vsplit $MYVIMRC') end)
vim.keymap.set('n', '<leader>vs', function() vim.cmd('source $MYVIMRC') end)
vim.keymap.set('n', '<leader>ze', function() vim.cmd('vsplit ~/.zshrc') end)

-- Enable folding
vim.keymap.set('n', '<leader>f', function() vim.opt.foldmethod = 'syntax' end)

-- Copy filename to system clipboard
vim.keymap.set(
  'n',
  '<leader>c',
  function()
    local filename = vim.fn.expand('%')
    -- `+` is the clipboard "selection register"
    vim.fn.setreg('+', filename)
  end
)
-- Copy filename:lineno to system clipboard
vim.keymap.set(
  'n',
  '<leader>C',
  function()
    local filename = vim.fn.expand('%')
    local lineno = vim.fn.line('.')
    -- `+` is the clipboard "selection register"
    vim.fn.setreg('+', filename .. ':' .. lineno)
  end
)

-- Navigate based on visual line breaks
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')

-- Escape from insert & command mode using `jj`
vim.keymap.set('i', 'jj', '<esc>l')
vim.keymap.set('c', 'jj', '<c-c>l')
-- Escape from visual mode using `v`
vim.keymap.set('v', 'v', '<esc>')

vim.keymap.set({ 'n', 'v' }, '<leader>j', '10j', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>k', '10k', { silent = true })

-- Make Y work like it's supposed to
vim.keymap.set('n', 'Y', 'y$')

-- Clear highlighting from last search
vim.keymap.set('n', '<c-c>', function() vim.cmd('nohlsearch') end)

-- Make n always go down and N always go up in a file
vim.keymap.set('n', 'n', function()
  if vim.v.searchforward == 1 then return 'n' else return 'N' end
end, { expr = true })
vim.keymap.set('n', 'N', function()
  if vim.v.searchforward == 1 then return 'N' else return 'n' end
end, { expr = true })

-- Find and replace word under cursor
-- Using the `:` format for a vim command allows it to be finished by the user
vim.keymap.set('n', '<leader>s', ':%s/\\<<c-r><c-w>\\>/')

vim.keymap.set('n', '<leader>u', function()
  vim.cmd('cprevious')
end)
vim.keymap.set('n', '<leader>o', function()
  vim.cmd('cnext')
end)
vim.keymap.set('n', '<leader>n', function()
  vim.diagnostic.goto_next()
end)
vim.keymap.set('n', '<leader>p', function()
  vim.diagnostic.goto_prev()
end)
vim.keymap.set('i', '<C-Y>', '<C-X><C-O>')

-- Use a vim-buffer-like pane for executing commands
vim.keymap.set('n', ':', 'q:i')

function _G.RgFromMotionIgnoreFilename(...)
  local old_selection = vim.opt.selection
  vim.opt.selection = 'inclusive'
  local old_reg_contents = vim.fn.getreg('a')
  vim.cmd('normal! `[v`]"ay')
  local quote_reg = vim.fn.getreg('a')
  vim.cmd('RgIgnoreFilename ' .. quote_reg)
  vim.opt.selection = old_selection
end

vim.keymap.set('n', 's', function()
  vim.opt.operatorfunc = 'v:lua.RgFromMotionIgnoreFilename'
  vim.api.nvim_feedkeys('g@', 'n', false)
end, { silent = true })
-- }}}
-- Language Specific configuration {{{
local filetype_ruby_augroup = vim.api.nvim_create_augroup('filetype_ruby', { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.rb" },
  command = 'iabbrev dbp Rails.logger.info("##### DEBUG #{}")<Left><Left><Left>',
  group = filetype_ruby_augroup
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.rb" },
  command = 'iabbrev dbd require \'pry-byebug\'; binding.pry',
  group = filetype_ruby_augroup
})
require('nu').setup({})
-- }}}
-- Language server configuration {{{
local lspconfig = require('lspconfig')
lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
lspconfig.cssls.setup({})
lspconfig.cssmodules_ls.setup({})
lspconfig.eslint.setup({})
lspconfig.gleam.setup({})
lspconfig.html.setup({})
lspconfig.jsonls.setup({})
lspconfig.lua_ls.setup({})
lspconfig.nushell.setup({})
lspconfig.pyright.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.solargraph.setup({ cmd = { 'bundle', 'exec', 'solargraph', 'stdio' } })
lspconfig.sqls.setup({})
lspconfig.terraformls.setup({})
lspconfig.tsserver.setup({})
lspconfig.vimls.setup({})
lspconfig.zls.setup({})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = args.buf })
    vim.keymap.set('n', 'gm', vim.lsp.buf.implementation, { buffer = args.buf })
    vim.keymap.set('n', 'gi', vim.diagnostic.open_float, { buffer = args.buf })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = args.buf })
    vim.keymap.set('n', 'gF', vim.lsp.buf.format, { buffer = args.buf })
  end,
})
-- }}}
-- Plugin Configuration {{{
-- Built-in plugin configuration {{{
vim.g.html_indent_inctags = 'p'
-- }}}
-- nvim-treesitter configuration {{{
require('nvim-treesitter.configs').setup({
  auto_install = true,
  highlight = {
    enable = true
  }
})
-- }}}
-- vim-hexokinase configuration {{{
vim.g.Hexokinase_virtualText = '███'
vim.g.Hexokinase_v2 = 0
-- }}}
-- fzf.vim configuration {{{
vim.api.nvim_create_user_command(
  'RgIgnoreFilename',
  function(opts)
    local spec = vim.fn['fzf#vim#with_preview']()
    spec.options = { '--delimiter', ':', '--nth', 4, unpack(spec.options) }
    vim.fn['fzf#vim#grep'](
      'rg --column --line-number --no-heading --color=always --smart-case -- ' .. vim.fn.shellescape(opts.args),
      spec,
      opts.bang and 1 or 0
    )
  end,
  { nargs = '*', bang = true }
)
vim.api.nvim_create_user_command(
  'RgIgnoreTests',
  function(opts)
    local spec = vim.fn['fzf#vim#with_preview']()
    spec.options = { '--delimiter', ':', '--nth', 4, unpack(spec.options) }
    vim.fn['fzf#vim#grep'](
      'rg --column --line-number --no-heading --color=always --smart-case --glob !test/ --glob !spec/ -- ' ..
      vim.fn.shellescape(opts.args),
      spec,
      opts.bang and 1 or 0
    )
  end,
  { nargs = '*', bang = true }
)
vim.keymap.set('n', '<leader>a', function() vim.cmd('Rg') end)
vim.keymap.set('n', '<leader>e', function() vim.cmd('RgIgnoreFilename') end)
vim.keymap.set('n', '<leader>t', function() vim.cmd('RgIgnoreTests') end)
vim.keymap.set('n', '<leader>b', function() vim.cmd('Buffers') end)
vim.keymap.set('n', '<C-N>', function() vim.cmd('Lines') end)
vim.keymap.set('n', '<C-P>', function() vim.cmd('Files') end)
-- }}}
-- targets.vim configuration {{{
vim.g.targets_argOpening = '[({[]'
vim.g.targets_argClosing = '[]})]'
-- }}}
-- vim-easy-align configuration {{{
vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')
vim.keymap.set({ 'v' }, '<Enter>', '<Plug>(EasyAlign)')
vim.g.easy_align_delimiters = {
  [';'] = { pattern = ':', left_margin = 1, right_margin = 0 }
}
-- }}}
-- vim-fugitive configuration {{{
vim.keymap.set({ 'n' }, 'gw', function() vim.cmd('Gwrite') end)
vim.keymap.set({ 'n' }, 'gs', function() vim.cmd('G status') end)
vim.keymap.set({ 'n' }, 'gc', function() vim.cmd('G commit -v') end)
vim.keymap.set({ 'n' }, 'gp', function() vim.cmd('G push') end)
vim.keymap.set({ 'n' }, 'gfp', function() vim.cmd('G push -f') end)
vim.keymap.set({ 'n' }, 'gy', function() vim.cmd('GBrowse!') end)
vim.keymap.set({ 'v' }, 'gy', function() vim.cmd('\'<\'>GBrowse!') end)
-- }}}
-- vim-test configuration {{{
vim.g['test#strategy'] = 'vimux'
vim.keymap.set({ 'n' }, '<leader>tn', function() vim.cmd('TestNearest') end)
vim.keymap.set({ 'n' }, '<leader>tl', function() vim.cmd('TestLast') end)
vim.keymap.set({ 'n' }, '<leader>tf', function() vim.cmd('TestFile') end)
-- }}}
-- vimux configuration {{{
vim.g.VimuxUseNearest = 1
-- }}}
-- vim-gitgutter configuration {{{
vim.opt.updatetime = 100
vim.keymap.set('n', '<leader>yp', '<Plug>(GitGutterPreviewHunk)')
vim.keymap.set('n', '<leader>yu', '<Plug>(GitGutterUndoHunk)')
vim.keymap.set('n', '<leader>ys', '<Plug>(GitGutterStageHunk)')
-- }}}
-- vim-slime configuration {{{
local TMUX = vim.env.TMUX
if TMUX ~= '' then
  vim.g.slime_default_config = {
    socket_name = vim.fn.split(TMUX, ',')[1],
    target_pane = ':.2'
  }
  vim.g.slime_target = 'tmux'
  vim.g.slime_no_mappings = 1
  vim.keymap.set({ 'x' }, '<c-s><c-s>', '<Plug>SlimeRegionSend')
  vim.keymap.set({ 'n' }, '<c-s><c-s>', '<Plug>SlimeParagraphSend')
  vim.keymap.set({ 'n' }, '<c-s>v', '<Plug>SlimeConfigSend')
end
-- }}}
-- LuaSnip configuration {{{
local ls = require("luasnip")
-- vim.keymap.set({"i"}, "<Tab>", function()
--   if vim.fn.pumvisible() == 1 then
--     ls.expand()
--     return
--   else
--     return "<Tab>"
--   end
-- end, {silent = true, expr = true })
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    ls.jump(1)
    return
  else
    return "<Tab>"
  end
end, { silent = true, expr = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    ls.jump(-1)
    return
  else
    return "<Tab>"
  end
end, { silent = true, expr = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })
require("luasnip.loaders.from_vscode").lazy_load()
-- }}}
-- nvim-cmp configuration {{{
local cmp = require('cmp')

cmp.setup({
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
    {
      { name = 'buffer' },
    }
  ),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  })
})
-- }}}
-- tmuxline configuration {{{
vim.g.tmuxline_powerline_separators = 0
vim.tmuxline_preset = {
  a = '#S',
  b = '#W',
  win = '#I #W',
  cwin = '#I #W',
  y = '%a %D',
  z = '%I:%M %p'
}
-- }}}
-- promptline configuration {{{
vim.g.promptline_theme = 'lightline'
vim.g.promptline_preset = {
  a = { vim.fn['promptline#slices#cwd']() },
  b = { vim.fn['promptline#slices#vcs_branch'](), vim.fn['promptline#slices#git_status']() },
  c = { vim.fn['promptline#slices#python_virtualenv']() },
  y = {},
  warn = { vim.fn['promptline#slices#last_exit_code']() },
}
vim.g.promptline_powerline_symbols = 0
-- }}}
-- vim-rails configuration {{{
vim.g.rails_projections = {
  ['*.js'] = { alternate = { '{}.spec.js' } },
  ['*.ts'] = { alternate = { '{}.spec.js' } },
  ['*.jsx'] = { alternate = { '{}.spec.jsx' } },
  ['*.tsx'] = { alternate = { '{}.spec.jsx' } },
  ['*.spec.js'] = { alternate = { '{}.ts', '{}.js' } },
  ['*.spec.ts'] = { alternate = { '{}.ts' } },
  ['*.spec.jsx'] = { alternate = { '{}.tsx', '{}.jsx' } },
  ['*.spec.tsx'] = { alternate = { '{}.tsx', '{}.jsx' } },
}
-- }}}
-- }}}
-- vim:foldmethod=marker
