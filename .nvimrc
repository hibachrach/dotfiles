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
Plug 'itchyny/lightline.vim'   " Extensible lightweight statusbar for vim
Plug 'junegunn/vim-peekaboo'   " To see vim register contents during reg access
Plug 'machakann/vim-highlightedyank' " Make the yanked region apparent!
Plug 'RRethy/vim-hexokinase' " Show colors for hexcodes in sign column

" Colorschemes
Plug '~/personal/programming/seoul256.vim'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'   " Fuzzy file search (hooked up to C-P for me)
Plug 'mileszs/ack.vim'    " Support Ag under Ack command with quickfix list integration

" Editor Keybindings/Motions
Plug 'tpope/vim-unimpaired'       " Pairs of useful keymappings
Plug 'tpope/vim-commentary'       " Easily (un)comment lines or blocks
Plug 'wellle/targets.vim'         " Add additional text objects and related goodies
Plug 'junegunn/vim-easy-align'    " To easily align repeating structures
Plug 'tpope/vim-surround'         " Easily add surrounding characters to text objects
Plug 'AndrewRadev/splitjoin.vim'  " Easily transition between one-line & multiline statements
Plug 'AndrewRadev/switch.vim'     " Easily switch between states/formats for various things
Plug 'tpope/vim-projectionist'

" Advanced text manipulation
Plug 'tpope/vim-abolish' " Case-smart replacement; case coercion
Plug 'kana/vim-textobj-user'

" Interfaces
Plug 'tpope/vim-eunuch'               " Adds nice Unix shortcuts to Vim
Plug 'tpope/vim-fugitive'             " Git wrapper for vim
Plug 'tpope/vim-rhubarb'              " GitHub wrapper for vim
Plug 'janko-m/vim-test'               " Running tests in vim
Plug 'benmills/vimux'                 " Send commands to tmux panes from vim; used in vim-test
Plug 'airblade/vim-gitgutter'         " Show changes in the left gutter; stage individual hunks
Plug 'christoomey/vim-tmux-navigator' " Enables vim-tmux nav with C-h/j/k/l keys
Plug 'jpalardy/vim-slime'             " Send commands over to another tmux pane!
Plug 'rizzatti/dash.vim'              " Query Dash.app from vim

 
" Autocompletion
if has('nvim')
  " Plug 'autozimu/LanguageClient-neovim', {
  "     \ 'branch': 'next',
  "     \ 'do': 'bash install.sh',
  "     \ }
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Not for Vim - Plugins that don't have anything to do with vim (weird, right?)
Plug 'edkolev/tmuxline.vim' " Customize tmux status bar in .vimrc
Plug 'edkolev/promptline.vim' " Customize shell prompt

" Language/library specific plugins
" Plug 'sheerun/vim-polyglot'
Plug '~/personal/programming/forks/ale'                     " Asynchronous linter
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'tpope/vim-bundler'            " Additional help with bundler and external gems
Plug 'tpope/vim-rails'              " Additional rails help
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'jsx'] }
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'junegunn/vader.vim', { 'for': 'vader' }
Plug 'rhysd/vim-crystal'
" Language/library specific plugins that I do not actively use
" For one reason or another, I don't code actively in these languages.
" However, I have found these useful when coding _in_ said languages

Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'digitaltoad/vim-pug', { 'for': ['vue', 'pug']}
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }  " React/JSX syntax highlighting/indenting
" Plug 'HerringtonDarkholme/yats.vim' " yet-another-typescript-syntax
" Plug 'fs111/pydoc.vim' 
" Plug 'zah/nim.vim'                  " Nim language support for [n]vim
Plug 'lervag/vimtex', { 'for': 'tex' }                " Vim plugin for working with .tex files
if has('nvim')
"   Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" 	Plug 'zchee/deoplete-jedi'
"   Plug 'vim-python/python-syntax'
"   Plug 'mhartington/nvim-typescript', { 'do': ':UpdateRemotePlugins' }
  Plug 'tweekmonster/deoplete-clang2'
  Plug '~/personal/programming/forks/deoplete-crystal', { 'for': 'crystal' }
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }
endif

" Misc. 
" Plug 'vimwiki/vimwiki' " A wiki in vim
Plug 'tpope/vim-dispatch' " Run :make async, with tmux support
Plug 'tweekmonster/startuptime.vim'

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
set shell=zsh\ --login
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

if executable('ripgrep')
  " Use ripgrep over grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  " Use ag over grep
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif
set keywordprg=:Dash!

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
  autocmd Filetype markdown set textwidth=80
  autocmd Filetype markdown set colorcolumn=+1,+2
  autocmd BufWritePost *.md silent! Make!
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

augroup filetype_rust
  autocmd!
  autocmd Filetype rust nmap gd <Plug>(rust-def)
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

function! BufferlineRefresh()
	call bufferline#refresh_status()
	let rlen = 4*tabpagenr('$') + 8
	call bufferline#trim_status_info(&columns - rlen)
	return ''
endfunction


" lightline configuration
let g:lightline = {
			\  'colorscheme': 'seoul256',
			\  'active':{
			\		'left': [ [ 'mode', 'paste' ], [], ['filename', 'linterstatus'] ],
			\		'right': [ ['lineinfo' ] , ['filetype'], ['fileencoding'], ]
			\  },
			\  'tab': {
			\    'active': ['tabnum'],
			\    'inactive': ['tabnum']
			\  },
			\  'tabline': {
			\ 	 	'left': [ ['tabs'], ['bufferline'] ],
			\  		'right': []
			\  },
			\  'component': {
      \		  'readonly': '%{&readonly?"RO":""}',
      \   	'bufferline': '%{BufferlineRefresh()}' . bufferline#get_status_string('TabLineSel', 'LightLineLeft_tabline_tabsel_1'),
			\   	'fileencoding': '%{&fenc}',
			\  },
			\  'component_function': {
			\		'ctrlpmark': 'CtrlPMark',
      \   'linterstatus': 'LightlineLinterStatus',
      \   'mode': 'LightLineMode',
			\  	},
			\ }

function! LightLineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
	return  winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineGitBranch()
	try
		if exists('*fugitive#head')
			let branchname = fugitive#head()
			return branchname !=# '' ? branchname : ''
		endif
	catch
	endtry
	return ''
endfunction

function! LightlineLinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction


" vim-hexokinase configuration
let g:Hexokinase_virtualText = '███'


" fzf.vim configuration
" ensure fzf respects .gitignore
let $FZF_DEFAULT_COMMAND ='ag -g ""'
nnoremap <Leader>a :Ag<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <C-N> :Lines<CR>
nnoremap <C-P> :Files<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <Leader>r :Rg<CR>


" ag.vim configuration
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

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
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gfp :Gpush -f<CR>


" vim-projectionist configuration
let g:projectionist_heuristics = {
  \ '*.cr': {
  \   'src/*.cr': { 'alternate': 'spec/{}_spec.cr' },
  \   'spec/*_spec.cr': { 'alternate': 'src/{}.cr' }
  \  }
  \}


" vim-test configuration
let test#strategy = "vimux"
nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tf :TestFile<CR>



" vimux configuration
let VimuxUseNearest = 1


" vim-gitgutter configuration
set updatetime=100
nmap <Leader>yp <Plug>GitGutterPreviewHunk
nmap <Leader>yu <Plug>GitGutterUndoHunk
nmap <Leader>ys <Plug>GitGutterStageHunk


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


" dash.vimm configuration
let g:dash_activate = 0 " Don't switch app focus to Dash


" LanguageClient-neovim configuration
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['solargraph', 'stdio'],
    \ }


" deoplete configuration
if has('nvim')
  " let g:deoplete#omni#functions = {}
  " let g:deoplete#omni#functions.ruby = 'rubycomplete#Complete'
  " let g:deoplete#omni#functions.haml = g:deoplete#omni#functions.ruby
  " let g:deoplete#omni#input_patterns = {}
  " let g:deoplete#omni#input_patterns.ruby = ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']
  " let g:deoplete#omni#input_patterns.haml = g:deoplete#omni#input_patterns.ruby
  " let g:deoplete#complete_method = 'omnifunc'
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#auto_refresh_delay = 200
  let g:deoplete#sources#crystal#lib = '/Users/harry/source-dirs/crystal/src'
  let g:deoplete#sources#crystal#bin = '/Users/harry/path_dependencies/cracker'
  let g:deoplete#enable_profile = 1
endif


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


" polyglot configuration
let g:polyglot_disabled = ['latex', 'jsx', 'conf'] " To ensure compatiblility with vimtex

" ale configuration
nmap <silent> <leader>n <Plug>(ale_previous_wrap)
nmap <silent> <leader>p <Plug>(ale_next_wrap)
nmap <silent> <leader>f <Plug>(ale_fix)
nmap <silent> <leader>i <Plug>(ale_detail)

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%] [%code%]'
" let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_fixers = {
\   'ruby': [
\       'rubocop'
\   ],
\   'python': [
\       'yapf'
\   ],
\   'jsx': [
\       'eslint'
\   ],
\   'html': [
\       'tidy'
\   ],
\   'xml': [
\       'tidy'
\   ],
\   'svg': [
\       'tidy'
\   ],
\}


" vim-ruby configuration
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
" Need this to override `ri`.
autocmd FileType ruby,eruby,haml set keywordprg=:Dash!


" vimtex configuration
let g:vimtex_view_general_viewer
			\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
augroup latexSurround
	autocmd!
	autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
	let b:surround_{char2nr("e")}
				\ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
	let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
	if !a:status | return | endif

	let l:out = b:vimtex.out()
	let l:cmd = [g:vimtex_view_general_viewer, '-r']
	if !empty(system('pgrep Skim'))
		call extend(l:cmd, ['-g'])
	endif
	if has('nvim')
		call jobstart(l:cmd + [line('.'), l:out])
	elseif has('job')
		call job_start(l:cmd + [line('.'), l:out])
	else
		call system(join(l:cmd + [line('.'), shellescape(l:out)], ' '))
	endif
endfunction


" rust.vim configuration
let g:rustfmt_autosave = 1


" " deoplete-ternjs configuration
" let g:deoplete#sources#ternjs#filteypes = [
"   \ 'jsx',
"   \ 'javascript.jsx',
"   \ 'vue',
"   \ 'coffee'
"   \ ]


" " python-syntax configuration
" let g:python_highlight_all = 1


" vimwiki configuration
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki',
			\'template_path': '~/Dropbox/vimwiki/templates/',
			\'template_default': 'default',
			\'template_ext': '.html',
			\'auto_export': 1,
			\'auto_toc': 0}]
" }}}
