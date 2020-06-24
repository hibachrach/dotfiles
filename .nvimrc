" -------
" PLUGINS
" -------
" {{{
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Enforcing sane behavior
Plug 'tpope/vim-sensible'            " Reasonable vim defaults
Plug 'tpope/vim-repeat'              " Make `.` work like it should
Plug 'tpope/vim-endwise'             " Automatically add `end` when in Ruby
Plug 'Townk/vim-autoclose'           " Automatic closure of parens, braces, and brackets
Plug '~/personal/traces.vim'         " Highlight patterns and ranges for Ex-commands

" UI - Plugins that don't *do* anything but display information
Plug 'critiqjo/vim-bufferline' " Enables tab-like list of buffers along top
Plug 'junegunn/vim-peekaboo'   " To see vim register contents during reg access
Plug 'machakann/vim-highlightedyank' " Make the yanked region apparent!
Plug 'RRethy/vim-hexokinase' " Show colors for hexcodes in sign column

" Colorschemes
Plug '~/personal/programming/seoul256.vim'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'   " Fuzzy file search (hooked up to C-P for me)
Plug 'chrisbra/matchit'

" Editor Keybindings/Motions
Plug 'tpope/vim-unimpaired'       " Pairs of useful keymappings
Plug 'tpope/vim-commentary'       " Easily (un)comment lines or blocks
Plug 'wellle/targets.vim'         " Add additional text objects and related goodies
Plug 'junegunn/vim-easy-align'    " To easily align repeating structures
Plug 'tpope/vim-surround'         " Easily add surrounding characters to text objects
Plug 'AndrewRadev/splitjoin.vim'  " Easily transition between one-line & multiline statements
Plug 'AndrewRadev/switch.vim'     " Easily switch between states/formats for various things

" Advanced text manipulation
Plug 'tpope/vim-abolish' " Case-smart replacement; case coercion

" Interfaces
Plug 'tpope/vim-eunuch'               " Adds nice Unix shortcuts to Vim
Plug 'tpope/vim-fugitive'             " Git wrapper for vim
Plug 'tpope/vim-rhubarb'              " Enable vim-fugitive to browse stuff on GitHub
Plug 'janko-m/vim-test'               " Running tests in vim
Plug 'benmills/vimux'                 " Send commands to tmux panes from vim; used in vim-test
Plug 'airblade/vim-gitgutter'         " Show changes in the left gutter; stage individual hunks
Plug 'christoomey/vim-tmux-navigator' " Enables vim-tmux nav with C-h/j/k/l keys
Plug 'jpalardy/vim-slime'             " Send commands over to another tmux pane!

 
" Autocompletion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Not for Vim - Plugins that don't have anything to do with vim (weird, right?)
Plug 'edkolev/tmuxline.vim' " Customize tmux status bar in .vimrc
Plug 'edkolev/promptline.vim' " Customize shell prompt

" Language/library specific plugins
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'tpope/vim-bundler'            " Additional help with bundler and external gems
Plug 'tpope/vim-rails'              " Additional rails help
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'yuezk/vim-js', { 'for': ['javascript', 'javascriptreact']}
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascriptreact']}
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'reasonml-editor/vim-reason-plus'
Plug 'elixir-editors/vim-elixir'
" Plug '~/personal/programming/forks/rubyfmt-vim'

" Language/library specific plugins that I do not actively use
" For one reason or another, I don't code actively in these languages.
" However, I have found these useful when coding _in_ said languages

" Plug 'ElmCast/elm-vim', { 'for': 'elm' }
" Plug 'junegunn/vader.vim', { 'for': 'vader' }
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }

" Misc. 
" Plug 'tweekmonster/startuptime.vim'

" Required vim-plug
call plug#end()
" }}}

" --------
" SETTINGS
" --------
" {{{
filetype on
set number                  " Show line numbers
set spelllang=en
set spell                   " Spellcheck (in comments & strings)
set hidden                  " Close windows without closing buffers
set expandtab               " Expand each press of <TAB> to appropriate number of spaces
set tabstop=2               " Number of spaces each tab corresponds to
set shiftwidth=2            " Number of spaces to indent to when using autoformatting
set cursorline              " Highlight the line the cursor is on
set ignorecase              " Ignore case when searching
set smartcase               " Add case sensitivity if any capital letters; requires ignorecase
set noshowmode              " Don't show the mode (INSERT, VISUAL, etc.) on the last line
set splitright              " So new splits open on the right
set undofile                " Keep undos in a file
set undodir=$HOME/.vim/undo " Sets undo file director
set undolevels=1000         " Max number of changes that can be undone
set undoreload=10000        " Save files <10,000 lines as an undo before executing :e!
set noswapfile              " Swap files aren't really necessary with git and undofiles
set showtabline=2           " Always show tab list; utilized by bufferline to show buffers
set cmdwinheight=1
set mouse+=a
set shell=zsh
if &term =~ '^xterm' && !has('nvim')
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

if has('termguicolors')
  set termguicolors " 24 bit terminal
endif


let g:seoul256_background = 235
colorscheme seoul256
let &colorcolumn=join(range(80,999),",")  " Sets cols >=79 to a different color

let g:currentmode={
      \ 'n'  : 'N',
      \ 'no' : 'N·Op Pending',
      \ 'v'  : 'V',
      \ 'V'  : 'VLine',
      \ '' : 'VBlock',
      \ 's'  : 'Select',
      \ 'S'  : 'S·Line',
      \ 'x19' : 'S·Block',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'Rv' : 'VReplace',
      \ 'c'  : 'Command',
      \ 'cv' : 'Vim Ex',
      \ 'ce' : 'Ex',
      \ 'r'  : 'Prompt',
      \ 'rm' : 'More',
      \ 'r?' : 'Confirm',
      \ '!'  : 'Shell',
      \ 't'  : 'Terminal'
      \}

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  if get(info, 'information', 0)
    call add(msgs, 'I' . info['information'])
  endif
  if empty(msgs) | return '[✓]' | endif
  return '[' . join(msgs, ' ') . ']'
endfunction

set statusline=[%{toupper(g:currentmode[mode()])}]
set statusline+=%{StatusDiagnostic()}
set statusline+=\   " space char literal
set statusline+=%<  " truncate here if too long
set statusline+=%f  " filename
set statusline+=\   " space char literal
set statusline+=%h  " help text indicator
set statusline+=%m  " modifiable flag
set statusline+=%r  " read only flag
set statusline+=%=  " alignment break
set statusline+=%y  " filetype
set statusline+=%14.([%l/%L:%v]%) " must be on one line to be processed correctly
" set statusline+=%14. " group must be min 14 characters (right aligned by default)
" set statusline+=(    " start of group
" set statusline+=[    " bracket literal
" set statusline+=%l   " line number
" set statusline+=/    " forward slash literal
" set statusline+=%L   " number of liens in buffer
" set statusline+=:    " colon literal
" set statusline+=%v   " "virtual" column number (num of visual chars from left)
" set statusline+=]    " bracket literal
" set statusline+=%)   " end of group
set statusline+=\   " space char literal
set statusline+=%P  " percent of way through file

set tabline=%1T


if executable('ripgrep')
  " Use ripgrep over grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  " Use ag over grep
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" Neovim specific items
if has('nvim')
  set inccommand=nosplit " Show replaced string *while* typing!
	set guicursor=         " Disable cursor styling
	set noshowcmd          " Don't show command in last line of screen
	set nolazyredraw       " Prevents visual glitches (probably nvim + iTerm2 issue)
endif
" }}}


" -----------
" KEYMAPPINGS
" -----------
" {{{
nmap <SPACE> <leader>
vmap <SPACE> <leader>
" Move to next buffer
nnoremap <leader>l :bnext<CR>
" Move to previous buffer
nnoremap <leader>h :bprevious<CR>
" Close current buffer and move to previous
nnoremap <leader>w :bp <BAR> bd #<CR>
" Easily edit .[n]vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
nnoremap <leader>ze :vsplit ~/.zshrc<CR>
nnoremap <leader>fe :vsplit ~/.config/fish/config.fish<CR>
" Copy filename to system clipboard
if executable('pbcopy')
  " Copies current filename to clipboard
  nnoremap <leader>c :call system("pbcopy", expand("%"))<CR>
  " Copies current filename and line number to clipboard
  nnoremap <leader>C :call system("pbcopy", expand("%") . ":" . line("."))<CR>
endif
" Navigate based on visual line breaks
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" Escape from insert & command mode using `jj`
inoremap jj <Esc>l
cnoremap jj <C-c>l
" Escape from visual mode using `v`
vnoremap v <Esc>
nnoremap <leader>k 10k
nnoremap <leader>j 10j
vnoremap <leader>k 10k
vnoremap <leader>j 10j
" Make Y work like it's supposed to
nnoremap Y y$
" Clear highlighting from last search
nnoremap <C-C> :noh<CR>
" Make n always go down and N always go up in a file
noremap <expr> n (v:searchforward ? 'n' : 'N')
noremap <expr> N (v:searchforward ? 'N' : 'n')

" Find and replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

nnoremap <Leader>u :cp<CR>
nnoremap <Leader>o :cn<CR>
nnoremap <silent> s :set operatorfunc=AgFromMotionIgnoreFilename<cr>g@
vnoremap <silent> s :<C-U>call AgFromMotionIgnoreFilename(visualmode(), 1)<cr>
nnoremap <silent> S :set operatorfunc=AgFromMotion<cr>g@
vnoremap <silent> S :<C-U>call AgFromMotion(visualmode(), 1)<cr>

function! AgFromMotionIgnoreFilename(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use gv command.
    silent exe "normal! gvy"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  else
    silent exe "normal! `[v`]y"
  endif

  exe ":AgIgnoreFilename " . @"

  let &selection = sel_save
  let @@ = reg_save
endfunction

function! AgFromMotion(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use gv command.
    silent exe "normal! gvy"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  else
    silent exe "normal! `[v`]y"
  endif

  exe ":Ag " . @"

  let &selection = sel_save
  let @@ = reg_save
endfunction


" Use a vim-buffer-like pane for executing commands 
nnoremap : q:i

if has('nvim')
	" Use `<TAB>` to scroll through pop-up menu
	inoremap <expr><TAB> pumvisible() ? "\<C-N>" : "\<TAB>"
	inoremap <expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"
endif
" }}}


" -----------
" COMMANDS
" -----------
" {{{
" Wrapping cnext/cprev!
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
" }}}


" ----------------------------------------
" LANGUAGE SPECIFFIC MAPPINGS/AUTOCOMMANDS
" ----------------------------------------
" {{{
augroup filetype_markdown
  autocmd!
  autocmd FileType markdown set spell
  autocmd FileType markdown set textwidth=80
  autocmd FileType markdown set colorcolumn=+1,+2
  autocmd FileType markdown iabbrev -> →
  autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
  autocmd BufWritePost *.md silent! make
augroup END

augroup filetype_typescript
  autocmd!
  autocmd BufWritePost *.ts silent! Make!
augroup END

augroup filetype_coffeescript
  autocmd!
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
augroup END

augroup filetype_ruby
  autocmd!
  autocmd Filetype ruby iabbrev dbp Rails.logger.info("##### DEBUG #{}")<Left><Left><Left>
  autocmd Filetype ruby iabbrev dbd require 'pry'; binding.pry
augroup END
" }}}


" ---------------------
" PLUGIN CONFIGURATIONS
" ---------------------
" {{{
" vim-highlightedyank configuration
if !has('nvim')
  map y <Plug>(highlightedyank)
endif


" vim-autoclose configuration
let g:AutoCloseExpandSpace = 0 " Make iabbrev work again


" bufferline configuration
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_show_bufnr = 0
let g:bufferline_fname_mod = ':~:.' " Make filename rel to home or cur directory
let g:bufferline_pathshorten = 1

autocmd BufEnter *
    \ let &tabline='%{bufferline#refresh_status()}' .
        \ bufferline#get_status_string('StatusLine', 'StatusLineNC')

" vim-hexokinase configuration
let g:Hexokinase_virtualText = '███'
let g:Hexokinase_v2 = 0


" fzf.vim configuration
" ensure fzf respects .gitignore
let $FZF_DEFAULT_COMMAND ='ag -g ""'
command! -bang -nargs=* AgIgnoreFilename call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* AgWithoutVCSIgnores call fzf#vim#ag(<q-args>, '--skip-vcs-ignores', {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <Leader>a :Ag<CR>
nnoremap <Leader>e :AgIgnoreFilename<CR>
nnoremap <Leader>q :AgWithoutVCSIgnores<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <C-N> :Lines<CR>
nnoremap <C-P> :Files<CR>



" targets.vim configuration
let g:targets_argOpening = '[({[]'
let g:targets_argClosing = '[]})]'


" vim-easy-align configuration
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" for aligning Ruby rocket-style hashes
let g:easy_align_delimiters = { ';': { 'pattern': ':', 'left_margin': 1, 'right_margin': 0 } }


" vim-fugitive configuration
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit -v<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gfp :Gpush -f<CR>
nnoremap <Leader>gy :.Gbrowse!<CR>
vnoremap <Leader>gy :'<'>Gbrowse!<CR>



" vim-test configuration
let test#strategy = "vimux"
nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tf :TestFile<CR>



" vimux configuration
let VimuxUseNearest = 1


" vim-gitgutter configuration
set updatetime=100
nmap <Leader>yp <Plug>(GitGutterPreviewHunk)
nmap <Leader>yu <Plug>(GitGutterUndoHunk)
nmap <Leader>ys <Plug>(GitGutterStageHunk)


" vim-slime configuration
if ($TMUX !=# "")
  let g:slime_default_config = { 'socket_name': split($TMUX, ',')[0], 'target_pane': ':.2' }
  let g:slime_target = "tmux"
  let g:slime_past_file = "$HOME/.slime_paste"
  let g:slime_no_mappings = 1
  xmap <c-s><c-s> <Plug>SlimeRegionSend
  nmap <c-s><c-s> <Plug>SlimeParagraphSend
  nmap <c-s>v     <Plug>SlimeConfig
endif



" coc.nvim configuration
nmap <silent> <leader>n <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>p <Plug>(coc-diagnostic-next)
nmap <silent> <leader>f <Plug>(coc-format)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" tmuxline configuration
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'y'    : '%a %D',
      \'z'    : '%I:%M %p'
	  \}


" promptline configuration
let g:promptline_theme = 'lightline'
let g:promptline_preset = {
        \'a' : [ promptline#slices#cwd() ],
        \'b' : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
        \'c' : [ promptline#slices#python_virtualenv() ],
        \'y' : [],
        \'warn' : [ promptline#slices#last_exit_code() ]}

let g:promptline_powerline_symbols = 0
